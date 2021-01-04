//
//  CryptocurrencyPriceParser.swift
//  GitHub_Learning
//
//  Created by Amin Ashhab on 20.12.2020.
//  Copyright © 2020 Amin_Second_Test_Project. All rights reserved.
//

import Foundation
import CleanCore

protocol CryptocurrencyParser {
    func parse(_ responseBody: DeserializedBody) throws -> Cryptocurrency
}

class CryptocurrencyParserImpl: Parser, CryptocurrencyParser {
    func parse(_ responseBody: DeserializedBody) throws -> Cryptocurrency {
        self.deserializedBody = responseBody
        let array = deserializedBody as? [Any]
        let dictionary = array?.first as? [String: Any]
        let price = dictionary?["current_price"] as? Int
        let symbol = dictionary?["symbol"] as? String
        let image = dictionary?["image"] as? String
        let priceChange = dictionary?["price_change_percentage_24h"] as? Double
        return Cryptocurrency(imageUrl: image, symbol: symbol, priceChange: priceChange, price: price)
    }
}
