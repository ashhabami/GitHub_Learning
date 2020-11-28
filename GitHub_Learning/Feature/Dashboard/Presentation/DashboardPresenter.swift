//
//  DashboardPresenter.swift
//  GitHub_Learning
//
//  Created by Amin Ashhab on 27.11.2020.
//  Copyright © 2020 Amin_Second_Test_Project. All rights reserved.
//

import Foundation
import CleanCore

protocol DashboardPresenter: Presenter {
    
}

final class DashboardPresenterImpl: BasePresenter<DashboardView> {
    
    let dashboardCotroller: DashboardController
    
    init(
        dashboardCotroller: DashboardController
    ) {
        self.dashboardCotroller = dashboardCotroller
    }
    
    func viewDidLoad() {
        view?.setEmail(dashboardCotroller.getEmail())
    }
}

extension DashboardPresenterImpl: DashboardPresenter {
    
}
