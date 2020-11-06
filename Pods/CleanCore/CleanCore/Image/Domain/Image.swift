//
//  Image.swift
//  FMC
//
//  Created by Libor Huspenina on 04/07/2016.
//  Copyright © 2016 Cleverlance. All rights reserved.
//

public class Image {

    public let data: Bytes

    public init(data: Bytes) {
        self.data = data
    }

    public init?(data: Bytes?) {
        if let data = data {
            self.data = data
        } else {
            return nil
        }
    }
}

extension Image: Equatable { }

public func == (lhs: Image, rhs: Image) -> Bool {
    return lhs.data == rhs.data
}
