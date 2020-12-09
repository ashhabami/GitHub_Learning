//
//  StartUpTests.swift
//  GitHub_LearningTests
//
//  Created by Amin Ashhab on 07.12.2020.
//  Copyright © 2020 Amin_Second_Test_Project. All rights reserved.
//

import XCTest
@testable import GitHub_Learning

class StartUpControllerTests: XCTestCase {
    private var sut: StartUpControllerImpl!
    private var loadOnboardingFinishedFacade: LoadOnboardingFinishedFacade!
    private var credentialKeychainController: CredentialKeychainController!
    private var wireframe: Wireframe!
    private var dashboardLauncherController: DashboardLauncherController!
}
