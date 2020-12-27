//
//  cryptoPriceResource.swift
//  GitHub_Learning
//
//  Created by Amin Ashhab on 20.12.2020.
//  Copyright © 2020 Amin_Second_Test_Project. All rights reserved.
//

import Foundation
import CleanCore

struct CryptoPriceRequest {}

typealias CryptoPriceResponse = Cryptocurrency  

protocol CryptocurrencyPriceResource {
    func getCryptocurrencyPrice() throws -> Cryptocurrency
}

class CryptocurrencyPriceResourceImpl: BaseHttpRemoteResource<CryptoPriceRequest, CryptoPriceResponse>, CryptocurrencyPriceResource {
    private let cryptocurrencyPriceParser: CryptocurrencyParser
    
    init(
        networkClient: HttpNetworkClient,
        errorParser: BusinessErrorParser,
        creationStep: RequestCreationStep,
        deserializationStrategy: ResponseBodyDeserializationStrategy,
        baseUrlConfig: BaseUrlConfig,
        cryptocurrencyPriceParser: CryptocurrencyParser
    ) {
        self.cryptocurrencyPriceParser = cryptocurrencyPriceParser
        super.init(
            networkClient: networkClient,
            errorParser: errorParser,
            creationStep: creationStep,
            deserializationStrategy: deserializationStrategy
        )
    }
    
    func getCryptocurrencyPrice() throws -> Cryptocurrency {
        let request = CryptoPriceRequest()
        return try makeRequest(request)
    }
    
    override func resourcePath(_ request: CryptoPriceRequest) throws -> String {
        return "https://api.coingecko.com/api/v3/coins/markets?&order=market_cap_desc&per_page=100&page=1&sparkline=false"
    }
    
    override func resourceMethod(_ request: CryptoPriceRequest) -> RequestMethod {
        return .get
    }
    
    override func requestContentType() -> ContentType {
        return .json
    }
    
    override func headersForRequest(_ request: CryptoPriceRequest) -> RequestHeaders? {
        return nil
    }
    
    override func parametersForRequest(_ request: CryptoPriceRequest) -> RequestParameters? {
        return ["vs_currency": "usd", "ids": "bitcoin", "price_change_percentage": "24h"]
    }
    
    override func bodyForRequest(_ request: CryptoPriceRequest) -> RequestBody? {
        return nil
    }
    
    override func mapResponseBodyToObject(_ responseBody: DeserializedBody?) throws -> CryptoPriceResponse {
        guard let responseBody = responseBody else {
            throw ResourceError.incorrectResponse
        }
        
        let response = try cryptocurrencyPriceParser.parse(responseBody)
        return response
    }
}
