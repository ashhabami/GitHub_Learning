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
    var cryptocurrenciesVM = [CryptocurrencyViewModel]()
    
    override func loadView() {
        view = layout
    }
    
    init(
        presenter: DashboardPresenter
    ) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
        tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout.dashboardTableView.delegate = self
        layout.dashboardTableView.dataSource = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Log Out", style: .done, target: self, action: #selector(logoutPressed))
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        layout.dashboardTableView.refreshControl = refreshControl
        presenter.viewDidLoad()
    }
    
    @objc func logoutPressed() {
        presenter.logOut()
    }
    
    @objc func refresh() {
        presenter.refresh {
            self.layout.dashboardTableView.refreshControl?.endRefreshing()
        }
    }
}

extension DashboardViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cryptocurrenciesVM.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CryptoPriceCell.identifier, for: indexPath) as! CryptoPriceCell
        cell.cryptocurrencyVM = cryptocurrenciesVM[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return HeaderView()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
}

extension DashboardViewController: DashboardView {
    func setCryptocurrency(_ cryptocurrencies: [CryptocurrencyViewModel]) {
        self.cryptocurrenciesVM = cryptocurrencies
        layout.dashboardTableView.reloadData()
    }
    func setEmail(_ email: String?) {
        title = email
    }
}
