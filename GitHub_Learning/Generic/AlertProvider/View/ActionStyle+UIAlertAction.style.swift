//
//  AlertAction+UIAlertAction.swift
//  GitHub_Learning
//
//  Created by Amin Ashhab on 23.11.2020.
//  Copyright © 2020 Amin_Second_Test_Project. All rights reserved.
//

import UIKit

extension ActionStyle {
    var alertStyle: UIAlertAction.Style {
        switch self {
        case ._default: return .default
        case .cancel: return .cancel
        case .destructive: return .destructive
        }
    }
}
