import XCTest
@testable import SwiftArgTests

XCTMain([
    testCase(LexerTests.allTests),
    testCase(OptionTests.allTests),
    testCase(ParserTests.allTests)
])

