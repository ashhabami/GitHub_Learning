//
//  DashboardViewController.swift
//  GitHub_Learning
//
//  Created by Amin Ashhab on 27.11.2020.
//  Copyright © 2020 Amin_Second_Test_Project. All rights reserved.
//

import UIKit
import CleanPlatform

class DashboardViewController: BaseViewController {
    
    private let layout = DashboardLayout()
    private let presenter: DashboardPresenter
    
    override func loadView() {
        view = layout
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout.logoutButton.addTarget(self, action: #selector(logoutPressed), for: .touchUpInside)
        presenter.viewDidLoad()
    }
    
    init(
        presenter: DashboardPresenter
    ) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func logoutPressed() {
        self.dismiss(animated: true, completion: nil)
        presenter.logOut()
    }
}

extension DashboardViewController: DashboardView {
    func setEmail(_ email: String?) {
        layout.dashboardLabel.text = "Welcome to the dashboard \(email ?? "unknown user")!"
    }
}
