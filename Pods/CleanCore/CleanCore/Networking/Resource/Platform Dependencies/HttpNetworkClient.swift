//
//  HttpNetworkClient.swift
//  Babylon
//
//  Created by Ondrej Fabian on 07/12/15.
//  Copyright © 2015 Cleverlance. All rights reserved.
//

import Foundation

public typealias RequestHeaders = [String: String]
public typealias RequestParameters = [String: Any]
public typealias RequestBody = String
public typealias Status = Int
public typealias ResponseHeaders = [String: String]
public typealias ResponseBody = Data

public enum RequestMethod {
    case get
    case post
    case put
    case delete
}

public struct HttpNetworkRequest {
    public let url: String
    public let method: RequestMethod
    public let contentType: ContentType
    public let acceptType: AcceptType
    public let headers: RequestHeaders?
    public let params: RequestParameters?
    public let body: RequestBody?

    public init(url: String, method: RequestMethod, contentType: ContentType, acceptType: AcceptType = .any, headers: RequestHeaders?, params: RequestParameters?, body: RequestBody?) {
        self.url = url
        self.method = method
        self.contentType = contentType
        self.acceptType = acceptType
        self.headers = headers
        self.params = params
        self.body = body
    }
}

public struct HttpNetworkResponse {
    public let status: Status
    public let headers: ResponseHeaders?
    public let body: ResponseBody?

    public init(status: Status, headers: ResponseHeaders?, body: ResponseBody?) {
        self.status = status
        self.headers = headers
        self.body = body
    }
}

public enum NetworkConnectionError: Error {
    case networkUnavailable
    case timeout
    case other
}

public enum NetworkClientError: Error {
    case networkConnectionError(type: NetworkConnectionError)
    case serverError
    case authenticationError
}

public protocol HttpNetworkClient {
    func request(_ request: HttpNetworkRequest) throws -> HttpNetworkResponse
}
