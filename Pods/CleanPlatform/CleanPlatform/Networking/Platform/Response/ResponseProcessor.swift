//
//  ResponseProcessor.swift
//  Creditas
//
//  Created by Ondrej Fabian on 10/12/15.
//  Copyright © 2015 Cleverlance. All rights reserved.
//

import CleanCore
import Foundation

public protocol ResponseProcessor {
    func parseResponse(_ responseRawBody: ResponseBody, httpUrlResponse: HTTPURLResponse) -> HttpNetworkResponse
}

public final class HTTPURLResponseProcessor: ResponseProcessor {
    public init() {}

    public func parseResponse(_ responseBody: ResponseBody, httpUrlResponse: HTTPURLResponse) -> HttpNetworkResponse {
        let responseHeaders = getHeaderFields(httpUrlResponse.allHeaderFields)
        return HttpNetworkResponse(status: httpUrlResponse.statusCode, headers: responseHeaders,
                                   body: responseBody)
    }

    private func getHeaderFields(_ allHeaderFields: [AnyHashable: Any]) -> [String: String] {
        var dict = [String: String]()

        for (key, value) in allHeaderFields {
            // swiftlint:disable force_cast
            dict[key as! String] = value as? String
            // swiftlint:enable force_cast
        }

        return dict
    }
}
