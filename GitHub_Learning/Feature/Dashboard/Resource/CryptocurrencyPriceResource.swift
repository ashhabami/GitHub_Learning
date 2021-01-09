//
//  cryptoPriceResource.swift
//  GitHub_Learning
//
//  Created by Amin Ashhab on 20.12.2020.
//  Copyright © 2020 Amin_Second_Test_Project. All rights reserved.
//

import Foundation
import CleanCore

struct CryptoPricesRequest {}

typealias CryptoPricesResponse = [Cryptocurrency]

protocol CryptocurrencyPriceResource {
    func getCryptocurrencyPrices() throws -> [Cryptocurrency]
}

class CryptocurrencyPriceResourceImpl: BaseHttpRemoteResource<CryptoPricesRequest, CryptoPricesResponse>, CryptocurrencyPriceResource {
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
    
    func getCryptocurrencyPrices() throws -> [Cryptocurrency] {
        let request = CryptoPricesRequest()
        return try makeRequest(request)
    }
    
    override func resourcePath(_ request: CryptoPricesRequest) throws -> String {
        return "https://api.coingecko.com/api/v3/coins/markets?"
    }
    
    override func resourceMethod(_ request: CryptoPricesRequest) -> RequestMethod {
        return .get
    }
    
    override func requestContentType() -> ContentType {
        return .json
    }
    
    override func headersForRequest(_ request: CryptoPricesRequest) -> RequestHeaders? {
        return nil
    }
    
    override func parametersForRequest(_ request: CryptoPricesRequest) -> RequestParameters? {
        return ["vs_currency": "usd", "order": "market_cap_desc", "price_change_percentage": "24h", "per_page": "20", "page": "1", "sparkline": "false"]
    }
    
    override func bodyForRequest(_ request: CryptoPricesRequest) -> RequestBody? {
        return nil
    }
    
    override func mapResponseBodyToObject(_ responseBody: DeserializedBody?) throws -> CryptoPricesResponse {
        guard let responseBody = responseBody else { throw ResourceError.incorrectResponse }
        let response = try cryptocurrencyPriceParser.parse(responseBody)
        return response
    }
}
