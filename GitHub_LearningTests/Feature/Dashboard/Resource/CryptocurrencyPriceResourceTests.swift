//
//  CryptocurrencyPriceResourceTests.swift
//  GitHub_LearningTests
//
//  Created by Amin Ashhab on 28.12.2020.
//  Copyright © 2020 Amin_Second_Test_Project. All rights reserved.
//

import XCTest
import CleanCore
@testable import GitHub_Learning

class CryptocurrencyPriceResourceTests: XCTestCase {
    private var sut: CryptocurrencyPriceResourceImpl!
    
    private func setupTest(
        httpNetworkClient: HttpNetworkClient = HttpNetworkClientDummy(),
        businessErrorParser: BusinessErrorParser = BusinessErrorParserDummy(),
        requestCreationStep: RequestCreationStep = RequestCreationStepDummy(),
        responseBodyDeserializationStrategy: ResponseBodyDeserializationStrategy = ResponseBodyDeserializationStrategyDummy(),
        baseUrlConfig: BaseUrlConfig = BaseUrlConfigDummy(),
        cryptocurrencyParser: CryptocurrencyParser = CryptocurrencyParserDummy()
    ) {
        self.sut = CryptocurrencyPriceResourceImpl(
            networkClient: httpNetworkClient,
            errorParser: businessErrorParser,
            creationStep: requestCreationStep,
            deserializationStrategy: responseBodyDeserializationStrategy,
            baseUrlConfig: baseUrlConfig,
            cryptocurrencyPriceParser: cryptocurrencyParser)
    }
    
    func test_givenSuccesResponse_whenGetCryptocurrency_thenCryptocurrencyIsValid() {
        // Given
        let string = "Success"
        let data = Data(string.utf8)
        let successResponse = HttpNetworkResponse(status: 200, headers: [:], body: data)
        setupTest(httpNetworkClient: HttpNetworkClientDummy(response: successResponse))
        
        // When
        let cryptocurrency = try? sut.getCryptocurrencyPrice()
        
        // Then
        XCTAssert(cryptocurrency != nil)
    }
    
    func test_givenClientError_whenGetCryptocurrency_thenClientErrorIsThrown() {
        // Given
        let string = "Failure"
        let data = Data(string.utf8)
        let successResponse = HttpNetworkResponse(status: 400, headers: ["":""], body: data)
        setupTest(httpNetworkClient: HttpNetworkClientDummy(response: successResponse))
        
        // When
        XCTAssertThrowsError(try sut.getCryptocurrencyPrice()) { error in
            guard let clientError = error as? ResourceError else {
                XCTFail()
                return
            }
            // Then
            XCTAssertEqual(clientError, ResourceError.business(businessError: BusinessError(code: 0, error: "Dummy Error", description: "Dummy Dummy")))
        }
    }
    
    func test_givenServerError_whenGetCryptocurrency_thenServerErrorIsThrown() {
        // Given
        let string = "Failure"
        let data = Data(string.utf8)
        let successResponse = HttpNetworkResponse(status: 500, headers: ["":""], body: data)
        setupTest(httpNetworkClient: HttpNetworkClientDummy(response: successResponse))
        
        // When
        XCTAssertThrowsError(try sut.getCryptocurrencyPrice()) { error in
            guard let serverError = error as? ResourceError else {
                XCTFail()
                return
            }
            // Then
            XCTAssertEqual(serverError, ResourceError.server)
        }
    }
    
    private class HttpNetworkClientDummy: HttpNetworkClient {
        private let response: HttpNetworkResponse?
        
        init(response: HttpNetworkResponse? = HttpNetworkResponse(status: 200, headers: ["Head":"Dummy"], body: Data())) {
            self.response = response
        }
        
        func request(_ request: HttpNetworkRequest) throws -> HttpNetworkResponse {
            guard let httpResponse = response else { throw ResourceError.remoteResource }
            return httpResponse
        }
    }
    
    private class BusinessErrorParserDummy: BusinessErrorParser {
        func parseError(status: Status, headers: ResponseHeaders?, body: DeserializedBody?) throws -> BusinessError {
            return BusinessError(code: 0, error: "Dummy Error", description: "Dummy Dummy")
        }
    }
    
    private class RequestCreationStepDummy: RequestCreationStep {
        func createRequest(from request: HttpNetworkRequest) throws -> HttpNetworkRequest {
            return request
        }
    }
    
    private class ResponseBodyDeserializationStrategyDummy: ResponseBodyDeserializationStrategy {
        func deserialize(_ data: ResponseBody) throws -> DeserializedBody {
            return data
        }
    }
    
    private class BaseUrlConfigDummy: BaseUrlConfig {
        func baseUrl() -> String {
            "https://"
        }
    }
    
    private class CryptocurrencyParserDummy: CryptocurrencyParser {
        func parse(_ responseBody: DeserializedBody) throws -> Cryptocurrency {
            return Cryptocurrency(imageUrl: "", symbol: "", priceChange: 0.0, price: 0)
        }
    }
}
