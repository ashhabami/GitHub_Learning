//
//  UIImage+Image.swift
//  FMC
//
//  Created by Libor Huspenina on 04/07/2016.
//  Copyright © 2016 Cleverlance. All rights reserved.
//

import UIKit
import Foundation
import CleanCore

public extension UIImage {

    convenience init?(image: Image) {
        let data = NSData(bytes: image.data, length: image.data.count)
        self.init(data: data as Data)
    }

    convenience init?(image: Image?) {
        if let image = image {
            self.init(image: image)
        } else {
            self.init()
            return nil
        }
    }
}
