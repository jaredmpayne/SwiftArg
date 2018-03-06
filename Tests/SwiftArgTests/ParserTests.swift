import XCTest
@testable import SwiftArg

class ParserTests: XCTestCase {
    
    func testInitialState() {
        let parser = Parser()
        
        XCTAssert(parser.executableArgument.isEmpty)
        XCTAssert(parser.unrecognizedArguments.isEmpty)
    }
    
    func testExecutableArgumentIsSetToFirstArgumentWhenArgumentsAreParsed() {
        let parser = Parser()
        
        let arguments = ["./the_executable"]
        parser.parse(arguments: arguments)
        
        XCTAssertEqual(parser.executableArgument, "./the_executable")
    }
    
    func testRaisesOptionWhenLongOptionIsParsed() {
        let parser = Parser()
        parser.addOption(names: ["verbose"])
        
        let arguments = ["./the_executable", "--verbose"]
        parser.parse(arguments: arguments)
        
        XCTAssert(parser.hasRaisedOption(named: "verbose"))
    }
    
    func testRaisesOptionWhenShortOptionIsParsed() {
        let parser = Parser()
        parser.addOption(names: ["f"])
        
        let arguments = ["./the_executable", "-f"]
        parser.parse(arguments: arguments)
        
        XCTAssert(parser.hasRaisedOption(named: "f"))
    }
    
    func testOptionsCanBeAccessedByAnyGivenName() {
        let parser = Parser()
        parser.addOption(names: ["version", "v"])
        
        let arguments = ["./the_executable", "-v"]
        parser.parse(arguments: arguments)
        
        XCTAssert(parser.hasRaisedOption(named: "version"))
    }
    
    func testOptionsWithConflictingNameDeferToLastOptionAdded() {
        let parser = Parser()
        parser.addOption(names: ["verbose", "v"])
        parser.addOption(names: ["version", "v"])
        
        let arguments = ["./the_executable", "-v"]
        parser.parse(arguments: arguments)
        
        XCTAssertFalse(parser.hasRaisedOption(named: "verbose"))
        XCTAssert(parser.hasRaisedOption(named: "version"))
    }
    
    func testPositionalArgumentsAreAddedToTheLastOptionRaised() {
        let parser = Parser()
        parser.addOption(names: ["output", "o"], maxValueCount: 1)
        
        let arguments = ["./the_executable", "-o", "file.txt"]
        parser.parse(arguments: arguments)
        
        XCTAssertNotNil(parser.valuesOfOption(named: "output"))
        XCTAssertEqual(parser.valuesOfOption(named: "output")!, ["file.txt"])
    }
    
    func testUnrecognizedLongOptionsAreAddedToTheUnrecognizedArgumentsArray() {
        let parser = Parser()
        
        let arguments = ["./the_executable", "--blah"]
        parser.parse(arguments: arguments)
        
        XCTAssertEqual(parser.unrecognizedArguments, ["--blah"])
    }
    
    func testUnrecognizedShortOptionsAreExtractedAndAddedToTheUnrecognizedArgumentsArray() {
        let parser = Parser()
        parser.addOption(names: ["r"])
        
        let arguments = ["./the_executable", "-rf"]
        parser.parse(arguments: arguments)
        
        XCTAssertEqual(parser.unrecognizedArguments, ["-f"])
    }
    
    func testExtraneousPositionalArgumentsAreAddedToTheUnrecognizedArray() {
        let parser = Parser()
        parser.addOption(names: ["output", "o"], maxValueCount: 1)
        
        let arguments = ["./the_executable", "-o", "file.txt", "extra.txt"]
        parser.parse(arguments: arguments)
        
        XCTAssertEqual(parser.unrecognizedArguments, ["extra.txt"])
    }
    
    static var allTests = [
        ("testInitialState",
         testInitialState),
        ("testExecutableArgumentIsSetToFirstArgumentWhenArgumentsAreParsed",
         testExecutableArgumentIsSetToFirstArgumentWhenArgumentsAreParsed),
        ("testRaisesOptionWhenLongOptionIsParsed",
         testRaisesOptionWhenLongOptionIsParsed),
        ("testRaisesOptionWhenShortOptionIsParsed",
         testRaisesOptionWhenShortOptionIsParsed),
        ("testOptionsCanBeAccessedByAnyGivenName",
         testOptionsCanBeAccessedByAnyGivenName),
        ("testOptionsWithConflictingNameDeferToLastOptionAdded",
         testOptionsWithConflictingNameDeferToLastOptionAdded),
        ("testPositionalArgumentsAreAddedToTheLastOptionRaised",
         testPositionalArgumentsAreAddedToTheLastOptionRaised),
        ("testUnrecognizedLongOptionsAreAddedToTheUnrecognizedArgumentsArray",
         testUnrecognizedLongOptionsAreAddedToTheUnrecognizedArgumentsArray),
        ("testUnrecognizedShortOptionsAreExtractedAndAddedToTheUnrecognizedArgumentsArray",
         testUnrecognizedShortOptionsAreExtractedAndAddedToTheUnrecognizedArgumentsArray),
        ("testExtraneousPositionalArgumentsAreAddedToTheUnrecognizedArray",
         testExtraneousPositionalArgumentsAreAddedToTheUnrecognizedArray)
    ]
}
