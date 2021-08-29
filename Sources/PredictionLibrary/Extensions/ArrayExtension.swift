//
//  File.swift
//  
//
//  Created by Simon Lion on 28.08.21.
//

import Foundation

// MARK: Extension
// This function does not make sense outside
internal extension Array where Element == String {
    
    func find(str: String, correction mistyped: Bool? = false, with percentage: Double? = 0.5) -> [String] {
        var resultsArray: [String] = []
        
        guard !str.isEmpty && !self.isEmpty else {
            return resultsArray
        }
        
        // Possible Multi Matches
        if self.count > 1 {
            for element in self {
                if element.lowercased().contains(str.lowercased()) || element.lowercased() == str.lowercased() {
                    resultsArray.append(element)
                }
                if let _ = element.lowercased().findPossibleMistyped(of: str, atLeast: percentage),
                   mistyped ?? false,
                   !resultsArray.contains(element) {
                    resultsArray.append(element)
                }
            }
            return resultsArray
        }
        // Only one match possible
        else {
            if self[0].lowercased().contains(str.lowercased()) {
                resultsArray.append(self[0])
                return resultsArray
            } else {
                return resultsArray
            }
        }
    }
}

