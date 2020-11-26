//
//  AlertAction+UIAlertAction.swift
//  GitHub_Learning
//
//  Created by Amin Ashhab on 26.11.2020.
//  Copyright © 2020 Amin_Second_Test_Project. All rights reserved.
//

import UIKit

extension UIAlertAction {
    convenience init(action: AlertAction) {
        self.init(title: action.title, style: action.style.alertStyle, handler: action.completion as ((UIAlertAction) -> Void)?)
    }
}
