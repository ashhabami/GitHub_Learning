//
//  MainAppNavigationController.swift
//  GitHub_Learning
//
//  Created by Amin Ashhab on 05.01.2021.
//  Copyright © 2021 Amin_Second_Test_Project. All rights reserved.
//

import UIKit

class MainAppNavigationController: UINavigationController {
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UINavigationBar.appearance().titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.black
        ]
        navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.black
        ]
        navigationBar.tintColor = .black
        navigationBar.isTranslucent = true
        navigationBar.shadowImage = UIImage()
    }
}
