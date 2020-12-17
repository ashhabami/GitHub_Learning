//
//  AlertProvider.swift
//  GitHub_Learning
//
//  Created by Amin Ashhab on 19/11/2020.
//  Copyright © 2020 Amin_Second_Test_Project. All rights reserved.
//

import Foundation
import CleanCore

enum ActionStyle {
    case `default`
    case cancel
    case destructive
}

struct AlertAction {
    let title: String
    let style: ActionStyle
    var completion: ((Any) -> Void)?
}

protocol AlertProviderController: BaseController {
    func showAlertWith(_ title: String, message: String, actions: [AlertAction]?)
}

class AlertProviderControllerImpl: BaseControllerImpl {
    private let wireframe: Wireframe
    
    init(
        wireframe: Wireframe
    ) {
        self.wireframe = wireframe
    }
}

extension AlertProviderControllerImpl: AlertProviderController {
    func showAlertWith(_ title: String, message: String, actions: [AlertAction]?) {
        wireframe.launchAlertWith(title, message: message, actions: actions)
    }
}
