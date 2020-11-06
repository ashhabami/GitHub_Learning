//
//  BusinessErrorParserImpl.swift
//  FMC
//
//  Created by Ondrej Fabian on 24/05/16.
//  Copyright © 2016 Cleverlance. All rights reserved.
//


public class BusinessErrorParserImpl: Parser, BusinessErrorParser {

    public func parseError(status: Status, headers: ResponseHeaders?, body: DeserializedBody?) throws -> BusinessError {
        let body = try body ?! ResourceError.incorrectResponse

        do {
            return try parseSamError(body)
        } catch {
            return try parseTcsError(body)
        }
    }

    private func parseSamError(_ response: DeserializedBody) throws -> BusinessError {
        self.deserializedBody = response

        let error = try getValue(String.self, forKey: "error")
        let description = try getValue(String.self, forKey: "error_description")

        let businessError = BusinessError(code: 0, error: error, description: description)

        return businessError
    }

    private func parseTcsError(_ response: DeserializedBody) throws -> BusinessError {
        self.deserializedBody = response

        let error = try getValue(String.self, forKey: "errorCode")
        let description = try getValue(String.self, forKey: "errorDescription")

        let businessError = BusinessError(code: 0, error: error, description: description)

        return businessError
    }
}
