//
//  MainAppTabBar.swift
//  GitHub_Learning
//
//  Created by Amin Ashhab on 05.01.2021.
//  Copyright © 2021 Amin_Second_Test_Project. All rights reserved.
//

import UIKit

class MainAppTabBarController: UITabBarController {
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.isTranslucent = true
        tabBar.shadowImage = UIImage()
        tabBar.unselectedItemTintColor = .lightGray
        tabBar.tintColor = .black
    }
}
