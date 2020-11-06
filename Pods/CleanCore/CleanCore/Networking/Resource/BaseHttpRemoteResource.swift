//
//  BaseHttpRemoteResource.swift
//  Creditas
//
//  Created by Ondrej Fabian on 07/12/15.
//  Copyright © 2015 Cleverlance. All rights reserved.
//

import Foundation

// swiftlint:disable variable_name
private let SuccessResponseRange = 200...299
private let ClientErrorRange = 400...499
private let ServerErrorRange = 500...599
// swiftlint:enable variable_name

public protocol RequestCreationStep {
    func createRequest(from request: HttpNetworkRequest) throws -> HttpNetworkRequest
}

open class BaseHttpRemoteResource<Request, Response> {

    let networkClient: HttpNetworkClient
    let errorParser: BusinessErrorParser
    let creationStep: RequestCreationStep
    private let deserializationStrategy: ResponseBodyDeserializationStrategy

    public init(networkClient: HttpNetworkClient, errorParser: BusinessErrorParser, creationStep: RequestCreationStep, deserializationStrategy: ResponseBodyDeserializationStrategy) {
        self.networkClient = networkClient
        self.errorParser = errorParser
        self.creationStep = creationStep
        self.deserializationStrategy = deserializationStrategy
    }

    public func makeRequest(_ request: Request) throws -> Response {

        let request = try createRequest(request)
        let response: HttpNetworkResponse

        do {
            response = try networkClient.request(request)
        } catch NetworkClientError.serverError {
            logWarning(NetworkClientError.serverError)
            throw ResourceError.server
        } catch {
            logWarning(error, domain: .network)
            throw ResourceError.remoteResource
        }

        switch response.status {
        case 401:
            logWarning(NetworkClientError.authenticationError, domain: .network)
            throw ResourceError.authentication
        case SuccessResponseRange:
            let body = try deserializeData(response.body)
            return try mapResponseBodyToObject(body)
        case ClientErrorRange:
            let businessError = try extractPossibleBusinessError(response)
            logWarning(businessError, domain: .network)
            throw ResourceError.business(businessError: businessError)
        case ServerErrorRange:
            logWarning("\(ServerErrorRange)", domain: .network)
            throw ResourceError.server
        default:
            throw ResourceError.remoteResource
        }
    }

    private func deserializeData(_ data: ResponseBody?) throws -> DeserializedBody? {
        guard let data = data else {
            return nil
        }

        do {
            return try deserializationStrategy.deserialize(data)
        } catch let error as ResponseBodyDeserializationStrategyError {
            logWarning(error, domain: .network)
            throw NetworkClientError.serverError
        }
    }

    // MARK: - Request
    private func createRequest(_ request: Request) throws -> HttpNetworkRequest {
        let url = try absoluteURLPath(request)
        let method = resourceMethod(request)
        let headers = headersForRequest(request)
        let params = parametersForRequest(request)
        let contentType = requestContentType()
        let acceptType = requestAcceptType()
        let body = bodyForRequest(request)
        let networkRequest = HttpNetworkRequest(url: url, method: method, contentType: contentType, acceptType: acceptType, headers: headers, params: params, body: body)
        let createdRequest = try creationStep.createRequest(from: networkRequest)
        return createdRequest
    }

    private func absoluteURLPath(_ request: Request) throws -> String {
        let path = try resourcePath(request)
        return path
    }

    // MARK: - Response
    private func extractPossibleBusinessError(_ networkResponse: HttpNetworkResponse) throws -> BusinessError {
        do {
            let body = try deserializeData(networkResponse.body)
            return try errorParser.parseError(status: networkResponse.status, headers: networkResponse.headers, body: body)
        } catch {
            throw ResourceError.client
        }
    }

    // MARK: - RemoteResource protocol - to be overridden by subclasses
    open func resourcePath(_ request: Request) throws -> String {
        fatalError("Subclasses must override!")
    }

    open func resourceMethod(_ request: Request) -> RequestMethod {
        fatalError("Subclasses must override!")
    }

    open func requestContentType() -> ContentType {
        fatalError("Subclasses must override!")
    }

    open func requestAcceptType() -> AcceptType {
        return .any
    }

    open func headersForRequest(_ request: Request) -> RequestHeaders? {
        fatalError("Subclasses must override!")
    }

    open func parametersForRequest(_ request: Request) -> RequestParameters? {
        fatalError("Subclasses must override!")
    }

    open func bodyForRequest(_ request: Request) -> RequestBody? {
        fatalError("Subclasses must override!")
    }

    open func mapResponseBodyToObject(_ responseBody: DeserializedBody?) throws -> Response {
        fatalError("Subclasses must override!")
    }
}
