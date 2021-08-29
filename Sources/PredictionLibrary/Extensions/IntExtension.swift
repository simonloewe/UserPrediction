//
//  File.swift
//  
//
//  Created by Simon Lion on 28.08.21.
//

import Foundation

internal extension Int {
    func getPercentage(to compared: Int) -> Double {
        if self >= compared {
            return 1.0
        } else {
            return Double(self) / Double(compared)
        }
    }
}
