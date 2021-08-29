//
//  StringPrediction.swift
//  
//
//  Created by Simon Lion on 28.08.21.
//

import Foundation
import SwiftUI

// TODO: Make Async
// TODO: If partialElement is multiple substrings search on every single one


protocol PredictableString {
    static func predict(input subItem: String, in str: String) -> String
    
    static func predict(input subItem: String, in array: [String]) -> [String]
    
    static func predict<T>(input subItem: String, in dictionary: Dictionary<T, String>) -> Dictionary<T, String>
    
    static func predict<T>(input subItem: String, in dictionary: Dictionary<String, T>) -> Dictionary<String, T>
    
    static func predictContinuous(input subItem: Binding<String>, in str: String, while condition: Bool, completion: @escaping (String) -> Void)
    
    static func predictContinuous(input subItem: Binding<String>, in str: [String], while condition: Bool, completion: @escaping ([String]) -> Void)
    
    static func predictContinuous<T>(input subItem: Binding<String>, in str: Dictionary<T, String>, while condition: Bool, completion: @escaping (Dictionary<T, String>) -> Void)
    
    static func predictContinuous<T>(input subItem: Binding<String>, in str: Dictionary<String, T>, while condition: Bool, completion: @escaping (Dictionary<String, T>) -> Void)
    
}

extension Prediction: PredictableString {
    //fileprivate var qualityOfServiceLevel: DispatchQoS.QoSClass = .background
    
    fileprivate static var correctionPercentage: Double = 0.5
    
    fileprivate static var withCorrection: Bool = true
    
    /// static so just one instance of this var exists which means it can later be changed
    fileprivate static var continous: Bool = false
    
    fileprivate static var invalidationTimer: Double = 60
    
    static func setCorrectionPercentage(new percentage: Double) {
        if percentage < 1.0 && percentage > 0.0 {
            Prediction.correctionPercentage = percentage
        }
    }
    
    static func setCorrection(new correction: Bool) {
        Prediction.withCorrection = correction
    }
    
    static func predict(input subItem: String, in str: String) -> String {
        var resultString = ""
        
        guard !str.isEmpty || !subItem.isEmpty else {
            return resultString
        }
        
        guard subItem != str else {
            return str
        }
        
        if str.split(separator: " ").count > 0 {
            for strElement in str.split(separator: " ") {
                if !strElement.lowercased().contains(subItem.lowercased()) {
                    continue
                } else {
                    resultString.append(contentsOf: strElement + " ")
                }
            }
            return resultString.removeTrailingSpace()
        } else {
            if str.lowercased().contains(subItem.lowercased()) {
                return str
            } else {
                return resultString.removeTrailingSpace()
            }
        }
    }
    
    // MARK: Predictable Implementation
    static func predict(input subItem: String, in array: [String]) -> [String] {
        return array.find(str: subItem, correction: Prediction.withCorrection, with: Prediction.correctionPercentage)
    }
    
    static func predict<T>(input subItem: String, in dictionary: Dictionary<T, String>) -> Dictionary<T, String> {
        var arrayTransformed: [String] = []
        var predictionDictionary: Dictionary<T,String> = [:]
        
        for (_, value) in dictionary {
            arrayTransformed.append(value)
        }
        let predictedValues = arrayTransformed.find(str: subItem, correction: Prediction.withCorrection, with: Prediction.correctionPercentage)
        for (key, value) in dictionary {
            if predictedValues.contains(value) {
                predictionDictionary[key] = value
            }
        }
        return predictionDictionary
    }
    
    static func predict<T>(input subItem: String, in dictionary: Dictionary<String, T>) -> Dictionary<String, T> {
        var arrayTransformed: [String] = []
        var predictionDictionary: Dictionary<String, T> = [:]
        
        for (key, _) in dictionary {
            arrayTransformed.append(key)
        }
        let predictedValues = arrayTransformed.find(str: subItem, correction: Prediction.withCorrection, with: Prediction.correctionPercentage)
        for (key, value) in dictionary {
            if predictedValues.contains(key) {
                predictionDictionary[key] = value
            }
        }
        return predictionDictionary
    }
    
    // MARK: Continous
    
    /// Predicts continously while condition is true or while 60 seconds have not passed
    /// Example of use:
    ///    TextField("Title", text: $text, onEditingChanged: { editing in
    ///        Prediction.predictContinous(partialElement: $text, in: "String", while: editing) { completion in
    ///            print("Prediction: ", completion)
    ///        }
    ///    })
    static func predictContinuous(input subItem: Binding<String>, in str: String, while condition: Bool, completion: @escaping (String) -> Void) {
        // Overwrite static class var continous
        Prediction.continous = condition
        let currentTime = Date()
        if Prediction.continous {
            Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
                completion(Prediction.predict(input: subItem.wrappedValue, in: str))
                if !Prediction.continous || currentTime.addingTimeInterval(Prediction.invalidationTimer) < Date() {
                    timer.invalidate()
                }
            }
        }
    }
    
    static func predictContinuous(input subItem: Binding<String>, in str: [String], while condition: Bool, completion: @escaping ([String]) -> Void) {
        // Overwrite static class var continous
        Prediction.continous = condition
        let currentTime = Date()
        if Prediction.continous {
            Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
                completion(Prediction.predict(input: subItem.wrappedValue, in: str))
                if !Prediction.continous || currentTime.addingTimeInterval(Prediction.invalidationTimer) < Date() {
                    timer.invalidate()
                }
            }
        }
    }
    
    static func predictContinuous<T>(input subItem: Binding<String>, in str: Dictionary<T, String>, while condition: Bool, completion: @escaping (Dictionary<T, String>) -> Void) {
        // Overwrite static class var continous
        Prediction.continous = condition
        let currentTime = Date()
        if Prediction.continous {
            Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
                completion(Prediction.predict(input: subItem.wrappedValue, in: str))
                if !Prediction.continous || currentTime.addingTimeInterval(Prediction.invalidationTimer) < Date() {
                    timer.invalidate()
                }
            }
        }
    }
    
    static func predictContinuous<T>(input subItem: Binding<String>, in str: Dictionary<String, T>, while condition: Bool, completion: @escaping (Dictionary<String, T>) -> Void) {
        // Overwrite static class var continous
        Prediction.continous = condition
        let currentTime = Date()
        if Prediction.continous {
            Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
                completion(Prediction.predict(input: subItem.wrappedValue, in: str))
                if !Prediction.continous || currentTime.addingTimeInterval(Prediction.invalidationTimer) < Date() {
                    timer.invalidate()
                }
            }
        }
    }
    
//    fileprivate static func intervallCaller<E>(returning returner: E, while condition: Bool, completion: @escaping (E) -> Void) {
//        Prediction.continous = condition
//        let currentTime = Date()
//        if Prediction.continous {
//            Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
//                completion(returner)
//                if !Prediction.continous || currentTime.addingTimeInterval(60) < Date() {
//                    timer.invalidate()
//                }
//            }
//        }
//    }
}
