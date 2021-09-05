//
//  File.swift
//  
//
//  Created by Simon Lion on 28.08.21.
//

import Foundation

internal extension String {
    func removeTrailingSpace() -> String {
        return self.replacingOccurrences(of: "\\s+$", with: "", options: .regularExpression)
    }
    
    // func findMistypeStringInArray(mistypedString str: String) -> [String] {}
    func findPossibleMistyped(of str: String, atLeast percentage: Double? = 0.5) -> String? {
        guard !self.isEmpty, !str.isEmpty else {
            return nil
        }
        
        let strArray = Array(str)
        let selfArray = Array(self)
        
        var counter: Int = 0
        for char in strArray {
            if selfArray.contains(char) {
                counter += 1
            }
        }
        
        if counter.getPercentage(to: strArray.count) >= percentage ?? 0.5 {
            return self
        } else {
            return nil
        }
    }
}
