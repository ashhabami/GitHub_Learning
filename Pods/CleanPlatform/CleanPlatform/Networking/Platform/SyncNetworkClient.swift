//
//  SyncNetworkClient.swift
//  Creditas
//
//  Created by Ondrej Fabian on 07/12/15.
//  Copyright © 2015 Cleverlance. All rights reserved.
//

import Foundation
import CleanCore

public final class SyncNetworkClient: NSObject, HttpNetworkClient, URLSessionDelegate {

    private let requestFactory: RequestFactory
    private let responseProcessor: ResponseProcessor
    private let networkConfig: NetworkClientConfig
    private let certificatesTrustHandler: CertificatesTrustHandler
    private let networkConnectionErrorParser: NetworkConnectionErrorParser
    private let sessionConfiguration: URLSessionConfiguration

    public init(requestFactory: RequestFactory, responseProcessor: ResponseProcessor, networkConfig: NetworkClientConfig, certificatesTrustHandler: CertificatesTrustHandler, networkConnectionErrorParser: NetworkConnectionErrorParser, sessionConfiguration: URLSessionConfiguration) {
        self.requestFactory = requestFactory
        self.responseProcessor = responseProcessor
        self.networkConfig = networkConfig
        self.certificatesTrustHandler = certificatesTrustHandler
        self.networkConnectionErrorParser = networkConnectionErrorParser
        self.sessionConfiguration = sessionConfiguration

        super.init()
    }

    public func request(_ request: HttpNetworkRequest) throws -> HttpNetworkResponse {
        let id = logIntervalStart("\(request)", domain: .network)

        let urlRequest = requestFactory.createNSURLRequest(request)
        let (data, urlResponse) = try sendSynchronousRequest(urlRequest)

        let response = responseProcessor.parseResponse(data, httpUrlResponse: urlResponse)
        logIntervalEnd("\(response)", id: id)

        return response
    }

    private func sendSynchronousRequest(_ urlRequest: URLRequest) throws
        -> (Data, HTTPURLResponse) {

        var urlData: Data?
        var urlResponse: URLResponse?
        var urlError: NSError?

        let semaphore: DispatchSemaphore = DispatchSemaphore(value: 0)

        let session = Foundation.URLSession(configuration: sessionConfiguration, delegate: self, delegateQueue: nil)

        session.dataTask(with: urlRequest, completionHandler: { data, response, error in
            urlData = data
            urlResponse = response
            urlError = error as NSError?

            semaphore.signal()
        }) .resume()

        _ = semaphore.wait(timeout: DispatchTime.distantFuture)

        if let error = urlError {
            logWarning(error, domain: .network)
            throw NetworkClientError.networkConnectionError(type: networkConnectionErrorParser.parse(error: error))
        }

        guard let data = urlData, let httpUrlResponse = urlResponse as? HTTPURLResponse else {
            throw NetworkClientError.serverError
        }

        return (data, httpUrlResponse)
    }

    public func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {

        if networkConfig.allowInvalidCertificates() {
            logDebug("URLAuthenticationChallenge.serverTrust", domain: .network)
            completionHandler(.useCredential, URLCredential(trust: challenge.protectionSpace.serverTrust!))
        } else {
            let protectedSpace = ProtectedSpace(host: challenge.protectionSpace.host)
            let certificates = convertCertificatesToData(from: challenge.protectionSpace.serverTrust!)
            if certificatesTrustHandler.allowCertificates(certificates, for: protectedSpace) {
                logDebug("URLAuthenticationChallenge.performDefaultHandling", domain: .network)
                completionHandler(.performDefaultHandling, nil)
            } else {
                logDebug("URLAuthenticationChallenge.cancelAuthenticationChallenge", domain: .network)
                completionHandler(.cancelAuthenticationChallenge, nil)
            }
        }
    }

    private func convertCertificatesToData(from trust: SecTrust) -> [Data] {
        let count = SecTrustGetCertificateCount(trust)
        var certificates: [Data] = []
        for index in 0..<count {
            if let certificateRef = SecTrustGetCertificateAtIndex(trust, index) {
                let certificateData: Data = SecCertificateCopyData(certificateRef) as Data
                certificates.append(certificateData)
            } else {
                certificates.append(Data())
            }
        }
        return certificates
    }
}
