    import XCTest
    import SwiftUI
    @testable import UserPrediction

    final class UserPredictionTests: XCTestCase {
        
        var newPrediction = UserPrediction()
        
        let arrayToFindStringIn = ["Str","St","S","A","B","C","D"]
        
        let dictToFindString1 = [1: "STR", 2: "ST", 3: "S", 4: "A", 5: "B", 6: "C"]
        let dictToFindString2 = ["STR": NSObject(), "ST": NSObject(), "S": NSObject(), "A": NSObject(), "B": NSObject(), "C": NSObject()]
        
        override func setUpWithError() throws {
            // Put setup code here. This method is called before the invocation of each test method in the class.
        }

        override func tearDownWithError() throws {
            // Put teardown code here. This method is called after the invocation of each test method in the class.
        }

        func testPredictionInArray(with correction: Bool = false) {
            UserPrediction.setCorrection(new: correction)
            XCTAssertTrue(UserPrediction.predict(input: "Str", in: arrayToFindStringIn).count == (correction ? 2 : 1))
            XCTAssertTrue(UserPrediction.predict(input: "St", in: arrayToFindStringIn).count == (correction ? 3 : 2))
            XCTAssertTrue(UserPrediction.predict(input: "S", in: arrayToFindStringIn).count == 3)
            
            XCTAssertTrue(UserPrediction.predict(input: "S t r", in: arrayToFindStringIn).count == 3)
            XCTAssertTrue(UserPrediction.predict(input: "S t", in: arrayToFindStringIn).count == 3)
        }
        
        func testPedictionInDictionary(with correction: Bool = false) {
            UserPrediction.setCorrection(new: correction)
            XCTAssertTrue(UserPrediction.predict(input: "Str", in: dictToFindString1).count == 1)
            XCTAssertTrue(UserPrediction.predict(input: "St", in: dictToFindString1).count == 2)
            XCTAssertTrue(UserPrediction.predict(input: "S", in: dictToFindString1).count == 3)
            
            XCTAssertTrue(UserPrediction.predict(input: "Str", in: dictToFindString2).count == 1)
            XCTAssertTrue(UserPrediction.predict(input: "St", in: dictToFindString2).count == 2)
            XCTAssertTrue(UserPrediction.predict(input: "S", in: dictToFindString2).count == 3)
        }
        
        func testPredictionInString(with correction: Bool = false) {
            UserPrediction.setCorrection(new: correction)
            XCTAssert(UserPrediction.predict(input: "Str", in: "") == "")
            XCTAssert(UserPrediction.predict(input: "Str", in: "Str") == "Str")
            XCTAssert(UserPrediction.predict(input: "Str", in: "Str aaa") == "Str")
            XCTAssert(UserPrediction.predict(input: "Str", in: "Str aaa Str") == "Str Str")
        }
    //
    //    func testPredictionInStringContinous(with correction: Bool = false) {
    //        Prediction.setCorrection(new: correction)
    //
    //    }

    }
