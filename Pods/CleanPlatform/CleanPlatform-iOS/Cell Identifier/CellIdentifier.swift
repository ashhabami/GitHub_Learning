//
//  CellIdentifier.swift
//  FMC
//
//  Created by Libor Huspenina on 01/07/2016.
//  Copyright © 2016 Cleverlance. All rights reserved.
//

import UIKit

public protocol CellIdentifier {
    static func cellIdentifier() -> String
}

extension CellIdentifier {
    public static func cellIdentifier() -> String {
        return "\(Self.self)"
    }
}

extension UITableViewCell: CellIdentifier { }
