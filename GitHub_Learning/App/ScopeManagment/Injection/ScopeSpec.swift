//
//  ScopeProvider.swift
//  GitHub_Learning
//
//  Created by Amin Ashhab on 06/11/2020.
//  Copyright © 2020 Amin_Second_Test_Project. All rights reserved.
//

import Foundation
import Swinject
import CleanPlatform

final class MainApplicationScopeSpec: ApplicationScopeSpec {
    public override func assemblies() -> [Assembly] {
        return super.assemblies() + [
            OnboardingAssembly(),
            NavigationAssembly(),
            LoginAssembly(),
            AlertProviderAssembly(),
            DashboardAssembly(),
            StartUpAssembly(),
            OnboardingPersistancyAssembly(),
            KeychainAssembly(),
            LogOutAssembly(),
            FavouritesAssembly(),
            NewsAssembly(),
            PortfolioAssembly()
        ]
    }
}
