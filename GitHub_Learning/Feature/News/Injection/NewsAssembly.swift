//
//  NewsAssembly.swift
//  GitHub_Learning
//
//  Created by Amin Ashhab on 05.01.2021.
//  Copyright © 2021 Amin_Second_Test_Project. All rights reserved.
//

import Foundation
import Swinject

class NewsAssembly: Assembly {
    func assemble(container: Container) {
        container.autoregister(NewsViewController.self, initializer: NewsViewController.init)
    }
}
