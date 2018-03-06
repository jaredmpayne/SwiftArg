import XCTest
@testable import SwiftArg

class OptionTests: XCTestCase {
    
    func testDefaultMaxValueCountIsZero() {
        let option = Option(names: ["version"])
        
        XCTAssertEqual(option.maxValueCount, 0)
    }
    
    func testCantAddMoreValuesThanMaxValueCount() {
        let option = Option(names: ["output"], maxValueCount: 1)
        
        XCTAssert(option.add(value: "input1.txt"))
        XCTAssertFalse(option.add(value: "input2.txt"))
    }
    
    static var allTests = [
        ("testDefaultMaxValueCountIsZero", testDefaultMaxValueCountIsZero),
        ("testCantAddMoreValuesThanMaxValueCount", testDefaultMaxValueCountIsZero)
    ]
}
