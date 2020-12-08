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
    func logOut()
}

final class DashboardPresenterImpl: BasePresenter<DashboardView> {
    private let logOutController: LogOutController
    private let dashboardCotroller: DashboardController
    
    init(
        dashboardCotroller: DashboardController,
        logOutController: LogOutController
    ) {
        self.dashboardCotroller = dashboardCotroller
        self.logOutController = logOutController
    }
    
    func viewDidLoad() {
        view?.setEmail(dashboardCotroller.getEmail())
    }
}

extension DashboardPresenterImpl: DashboardPresenter {
    func logOut() {
        logOutController.logOut()
    }
}
