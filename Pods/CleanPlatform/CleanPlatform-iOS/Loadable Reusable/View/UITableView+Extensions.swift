//
//  UITableView+Extensions.swift
//  CleanPlatform_iOS
//
//  Created by Jan Halousek on 09/04/2019.
//  Copyright © 2019 Cleverlance. All rights reserved.
//

import UIKit

public protocol LoadableCell: Reusable, Loadable {}

public extension UITableView {
    func registerCell<U>(_: U.Type) where U: Reusable, U: Loadable, U: UITableViewCell {
        register(U.nib, forCellReuseIdentifier: U.reusableIdentifier)
    }

    func registerCellClass<U>(_: U.Type) where U: Reusable, U: UITableViewCell {
        register(U.self, forCellReuseIdentifier: U.reusableIdentifier)
    }

    func registerHeaderFooterViewClass<U>(_: U.Type) where U: Reusable, U: UITableViewHeaderFooterView {
        register(U.self, forHeaderFooterViewReuseIdentifier: U.reusableIdentifier)
    }

    func registerHeaderFooterView<U>(_: U.Type) where U: Loadable, U: Reusable, U: UITableViewHeaderFooterView {
        register(U.nib, forHeaderFooterViewReuseIdentifier: U.reusableIdentifier)
    }

    func dequeueReusableCell<U>(_: U.Type, for indexPath: IndexPath) -> U where U: Reusable, U: UITableViewCell {
        return dequeueReusableCell(withIdentifier: U.reusableIdentifier, for: indexPath) as! U
    }

    func dequeueReusableCell<U>(_: U.Type) -> U? where U: Reusable, U: UITableViewCell {
        return dequeueReusableCell(withIdentifier: U.reusableIdentifier) as? U
    }

    func dequeueReusableHeaderFooterView<U>(_: U.Type) -> U? where U: Reusable, U: UITableViewHeaderFooterView {
        return dequeueReusableHeaderFooterView(withIdentifier: U.reusableIdentifier) as? U
    }
}
