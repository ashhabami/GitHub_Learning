//
//  LogOutController.swift
//  GitHub_Learning
//
//  Created by Amin Ashhab on 07.12.2020.
//  Copyright © 2020 Amin_Second_Test_Project. All rights reserved.
//

import Foundation
import CleanCore

protocol LogOutController: BaseController {
    func logOut()
}

final class LogOutControllerImpl: BaseControllerImpl {
    private let wireframe: Wireframe
    
    init(
        wireframe: Wireframe
    ) {
        self.wireframe = wireframe
    }
}

extension LogOutControllerImpl: LogOutController {
    func logOut() {
        wireframe.dissmisModalPresentation()
    }
}
