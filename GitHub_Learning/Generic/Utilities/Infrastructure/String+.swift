//
//  String+.swift
//  GitHub_Learning
//
//  Created by Amin Ashhab on 19/11/2020.
//  Copyright © 2020 Amin_Second_Test_Project. All rights reserved.
//

import Foundation

extension String {
    var containsNumber: Bool {
        let numbersRange = self.rangeOfCharacter(from: .decimalDigits)
        return numbersRange != nil
    }
    
    var containsCapital: Bool {
        let numbersRange = self.rangeOfCharacter(from: .capitalizedLetters)
        return numbersRange != nil
    }
}
