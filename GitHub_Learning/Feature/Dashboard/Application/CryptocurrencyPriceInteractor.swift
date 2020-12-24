//
//  CryptocurrencyPriceInteractor.swift
//  GitHub_Learning
//
//  Created by Amin Ashhab on 20.12.2020.
//  Copyright © 2020 Amin_Second_Test_Project. All rights reserved.
//

import Foundation
import CleanCore

struct CryptocurrencyRequest: Equatable {
    init() {}
    
    static func == (lhs: CryptocurrencyRequest, rhs: CryptocurrencyRequest) -> Bool {
        return true
    }
}

struct CryptocurrencyResponse {
    let cryptocurrency: Cryptocurrency
    
    init(cryptocurrency: Cryptocurrency) {
        self.cryptocurrency = cryptocurrency
    }
}

final class CryptocurrencyInteractor: Interactor {
    private let cryptocurrencyPriceResource: CryptocurrencyPriceResource
    
    init(cryptocurrencyPriceResource: CryptocurrencyPriceResource) {
        self.cryptocurrencyPriceResource = cryptocurrencyPriceResource
    }
    
    public func execute(_ request: CryptocurrencyRequest) throws -> CryptocurrencyResponse {
        let cryptocurrency = try cryptocurrencyPriceResource.getCryptocurrencyPrice()
        return CryptocurrencyResponse(cryptocurrency: cryptocurrency)
    }
    
    public static func == (lhs: CryptocurrencyInteractor, rhs: CryptocurrencyInteractor) -> Bool {
        return true
    }
}
