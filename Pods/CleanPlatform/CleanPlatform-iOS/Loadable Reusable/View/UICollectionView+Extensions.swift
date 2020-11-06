//
//  UICollectionView+Extensions.swift
//  CleanPlatform_iOS
//
//  Created by Jan Halousek on 09/04/2019.
//  Copyright © 2019 Cleverlance. All rights reserved.
//

import UIKit

public extension UICollectionView {
    func registerCell<U>(_: U.Type) where U: Reusable, U: Loadable, U: UICollectionViewCell {
        register(U.nib, forCellWithReuseIdentifier: U.reusableIdentifier)
    }

    func registerClass<U>(_ cellType: U.Type) where U: Reusable, U: UICollectionViewCell {
        register(cellType, forCellWithReuseIdentifier: U.reusableIdentifier)
    }

    func registerSupplementaryView<U>(_: U.Type, forSupplementaryViewOfKind kind: String) where U: Reusable, U: Loadable, U: UICollectionReusableView {
        register(U.nib, forSupplementaryViewOfKind: kind, withReuseIdentifier: U.reusableIdentifier)
    }

    func dequeueReusableCell<U>(_: U.Type, for indexPath: IndexPath) -> U where U: Reusable, U: UICollectionViewCell {
        return dequeueReusableCell(withReuseIdentifier: U.reusableIdentifier, for: indexPath) as! U
    }

    func dequeueReusableSupplementaryView<U>(_: U.Type, ofKind kind: String, for indexPath: IndexPath) -> U where U: Reusable, U: UICollectionReusableView {
        return dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: U.reusableIdentifier, for: indexPath) as! U
    }
}
