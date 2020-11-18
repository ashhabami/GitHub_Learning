//
//  FakeOnboardingView.swift
//  GitHub_LearningTests
//
//  Created by Amin Ashhab on 16/11/2020.
//  Copyright © 2020 Amin_Second_Test_Project. All rights reserved.
//

import Foundation
import CleanCore

class TestView: View {
    var isLoading: Bool?
    
    func startLoading() {
        isLoading = true
    }
    
    func stopLoading() {
        isLoading = false
    }
}
