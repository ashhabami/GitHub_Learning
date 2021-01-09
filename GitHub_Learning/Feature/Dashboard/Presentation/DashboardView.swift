//
//  DashboardView.swift
//  GitHub_Learning
//
//  Created by Amin Ashhab on 28.11.2020.
//  Copyright © 2020 Amin_Second_Test_Project. All rights reserved.
//

import Foundation
import CleanCore

protocol DashboardView: View {
    func setEmail(_ email: String?)
    func setCryptocurrency(_ cryptocurrencies: [CryptocurrencyViewModel])
}
