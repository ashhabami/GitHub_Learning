//
//  CryptocurrencyPriceFacade.swift
//  GitHub_Learning
//
//  Created by Amin Ashhab on 20.12.2020.
//  Copyright © 2020 Amin_Second_Test_Project. All rights reserved.
//

import Foundation
import CleanCore

protocol CryptocurrencyPricesFacade {
    func getCryptocurrencyPrice(completion: @escaping (Result<CryptocurrencyResponse>) -> Void)
}

final class CryptocurrencyPricesFacadeImpl: CommandFacadeImpl<CryptocurrencyInteractor, CryptocurrencyRequest, CryptocurrencyResponse>, CryptocurrencyPricesFacade {
    
    init(invoker: Invoker, receiver: CryptocurrencyInteractor) {
        super.init(invoker: invoker, receiver: receiver)
    }
    
    func getCryptocurrencyPrice(completion: @escaping (Result<CryptocurrencyResponse>) -> Void) {
        execute(CryptocurrencyRequest(), completion: completion)
    }
}
