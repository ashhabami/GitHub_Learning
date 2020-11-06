//
//  RequestFactory.swift
//  Creditas
//
//  Created by Ondrej Fabian on 10/12/15.
//  Copyright © 2015 Cleverlance. All rights reserved.
//

import CleanCore
import Foundation

public protocol RequestFactory {
    func createNSURLRequest(_ networkRequest: HttpNetworkRequest) -> URLRequest
}

public final class URLRequestFactory: RequestFactory {

    private let urlEncoder: UrlEncoder

    public init(urlEncoder: UrlEncoder) {
        self.urlEncoder = urlEncoder
    }

    public func createNSURLRequest(_ request: HttpNetworkRequest) -> URLRequest {
        let urlRequest = NSMutableURLRequest()
        urlRequest.url = makeURL(request.url, method: request.method, parameters: request.params)
        urlRequest.allHTTPHeaderFields = addHeaders(request.headers, contentType: request.contentType, acceptType: request.acceptType)
        urlRequest.httpMethod = methodString(request.method)

        if let body = request.body {
            urlRequest.httpBody = encodeBodyString(body)
        } else if request.method != .get {
            urlRequest.httpBody = makeRequestBodyDataIfAnyParams(request.params, contentType: request.contentType)
        }
        return urlRequest as URLRequest
    }

    private func methodString(_ method: RequestMethod) -> String {
        switch method {
        case .get:
            return "GET"
        case .post:
            return "POST"
        case .put:
            return "PUT"
        case .delete:
            return "DELETE"
        }
    }

    private func addHeaders(_ possibleHeaders: RequestHeaders?, contentType: ContentType, acceptType: AcceptType) -> RequestHeaders {
        var headers = possibleHeaders ?? RequestHeaders()
        headers["Accept"] = acceptTypeString(acceptType)
        headers["Content-Type"] = contentTypeString(contentType)
        return headers
    }

    private func contentTypeString(_ contentType: ContentType) -> String {
        switch contentType {
        case .wwwFormUrlEncoded:
            return "application/x-www-form-urlencoded"
        case .json:
            return "application/json"
        }
    }

    private func acceptTypeString(_ acceptType: AcceptType) -> String {
        switch acceptType {
        case .any:
            return "*/*"
        case .xml:
            return "application/xml"
        case .json:
            return "application/json"
        }
    }

    private func makeRequestBodyDataIfAnyParams(_ requestParameters: RequestParameters?, contentType: ContentType) -> Data? {
        var bodyData: Data?
        if let params = requestParameters, !params.isEmpty {
            bodyData = makeRequestBodyData(params, contentType: contentType)
        }
        return bodyData
    }

    private func makeRequestBodyData(_ requestParameters: RequestParameters, contentType: ContentType) -> Data? {
        var bodyData: Data?
        switch contentType {
        case .json:
            bodyData = try? JSONSerialization.data(withJSONObject: requestParameters, options: [])
        case .wwwFormUrlEncoded:
            let bodyString = makeUrlRequestBodyString(requestParameters)
            bodyData = encodeBodyString(bodyString)
        }
        return bodyData
    }

    private func makeUrlRequestBodyString(_ params: RequestParameters) -> String {
        return params
            .mapValues { urlEncoder.urlEncodeParameter("\($0)") }
            .map { "\($0)=\($1)" }
            .joined(separator: "&")
    }

    private func encodeBodyString(_ bodyString: String) -> Data? {
        let data = bodyString.data(using: String.Encoding.utf8, allowLossyConversion: false)
        return data
    }

    private func makeURL(_ urlString: String, method: RequestMethod, parameters: RequestParameters?) -> URL? {
        var urlComponents = URLComponents(string: urlString)

        if method == .get {
            urlComponents?.percentEncodedQuery = parameters?.map {
                urlEncoder.urlEncodeParameter($0.key) + "=" + urlEncoder.urlEncodeParameter("\($0.value)")
            }.joined(separator: "&") ?? ""
        }
        return urlComponents?.url
    }
}
