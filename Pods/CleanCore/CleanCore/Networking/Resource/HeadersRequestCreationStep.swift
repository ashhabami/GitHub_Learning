//
//  HeadersRequestCreationStep.swift
//  FMC
//
//  Created by Ondrej Fabian on 19/07/16.
//  Copyright © 2016 Cleverlance. All rights reserved.
//

public final class HeadersRequestCreationStep: RequestCreationStep {

    let config: HeadersConfig

    public init(config: HeadersConfig) {
        self.config = config
    }

    public func createRequest(from request: HttpNetworkRequest) -> HttpNetworkRequest {
        let url = request.url
        let method = request.method
        let contentType = request.contentType
        let acceptType = request.acceptType
        var headers = request.headers ?? [:]
        let params = request.params
        let body = request.body

        for (key, value) in config.headers() {
            headers[key] = value
        }

        return HttpNetworkRequest(url: url, method: method, contentType: contentType, acceptType: acceptType, headers: headers, params: params, body: body)
    }
}
