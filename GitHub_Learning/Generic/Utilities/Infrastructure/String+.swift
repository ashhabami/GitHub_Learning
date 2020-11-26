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
        let isCapital = self.filter {
            $0.isUppercase
        }.first
        return isCapital != nil
    }
    
    var length: Int {
        return self.count
    }
    
    var hasEmailCharacters: Bool {
        do {
            let regex = try NSRegularExpression(pattern: "[\\w.]+@[a-zA-Z]{2,}\\.[a-zA-Z]{2,3}\\b", options: [])
            if let _ = regex.firstMatch(in: self, options: NSRegularExpression.MatchingOptions.reportCompletion, range: NSMakeRange(0, self.count)) {
                return true
            }
        } catch {
            debugPrint(error.localizedDescription)
            return false
        }
        return false
    }
}
