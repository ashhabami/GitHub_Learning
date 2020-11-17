//
//  WireframeImpl.swift
//  GitHub_Learning
//
//  Created by Amin Ashhab on 15/11/2020.
//  Copyright © 2020 Amin_Second_Test_Project. All rights reserved.
//

import Foundation
import CleanCore
import CleanPlatform

//Deinitnou se někdy ty původní objekty když na sebe ukazují a vytváří obřího pavouka odkazů?
class WireframeImpl: Wireframe {
    let instanceProvider: InstanceProvider
    let window: UIWindow
    
    init(
        instanceProvider: InstanceProvider,
        window: UIWindow
    ) {
        self.instanceProvider = instanceProvider
        self.window = window
    }
    
    func launchLogin() {
        let vc = try! instanceProvider.getInstance(LoginViewController.self)
        vc.modalPresentationStyle = .fullScreen
        window.topViewController?.present(vc,animated: true,completion: nil)
    }
}
