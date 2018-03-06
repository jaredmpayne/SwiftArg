import XCTest
@testable import SwiftArg

class LexerTests: XCTestCase {
    
    func testReturnsLongOptionTokenWhenPassedArgumentStartingWithTwoHyphens() {
        let arguments = ["--help"]
        
        let tokens = Lexer().lex(arguments: arguments)
        
        XCTAssertEqual(tokens, [
            Token(value: "--help", lexType: .longOption)
            ])
    }
    
    func testReturnsShortOptionTokenWhenPassedArgumentStartingWithOneHyphen() {
        let arguments = ["-v"]
        
        let tokens = Lexer().lex(arguments: arguments)
        
        XCTAssertEqual(tokens, [
            Token(value: "-v", lexType: .shortOption)
            ])
    }
    
    func testReturnsPositionalArgumentTokenWhenPassedArgumentStartingWithNoHyphens() {
        let arguments = ["positional"]
        
        let tokens = Lexer().lex(arguments: arguments)
        
        XCTAssertEqual(tokens, [
            Token(value: "positional", lexType: .positionalArgument)
            ])
    }
    
    func testExpandsLongOptionValueAssignmentsIntoLongOptionAndPositionalArgumentTokens() {
        let arguments = ["--output=file.txt"]
        
        let tokens = Lexer().lex(arguments: arguments)
        
        XCTAssertEqual(tokens, [
            Token(value: "--output", lexType: .longOption),
            Token(value: "file.txt", lexType: .positionalArgument)
            ])
    }
    
    func testReturnsShortOptionTokenWhenLongOptionContainsNoCharacters() {
        let arguments = ["--"]
        
        let tokens = Lexer().lex(arguments: arguments)
        
        XCTAssertEqual(tokens, [
            Token(value: "--", lexType: .shortOption)
            ])
    }
    
    func testReturnsPositionalArgumentTokenWhenShortOptionContainsNoCharacters() {
        let arguments = ["-"]
        
        let tokens = Lexer().lex(arguments: arguments)
        
        XCTAssertEqual(tokens, [
            Token(value: "-", lexType: .positionalArgument)
            ])
    }
    
    static var allTests = [
        ("testReturnsLongOptionTokenWhenPassedArgumentStartingWithTwoHyphens",
         testReturnsLongOptionTokenWhenPassedArgumentStartingWithTwoHyphens),
        ("testReturnsShortOptionTokenWhenPassedArgumentStartingWithOneHyphen",
         testReturnsShortOptionTokenWhenPassedArgumentStartingWithOneHyphen),
        ("testReturnsPositionalArgumentTokenWhenPassedArgumentStartingWithNoHyphens",
         testReturnsPositionalArgumentTokenWhenPassedArgumentStartingWithNoHyphens),
        ("testExpandsLongOptionValueAssignmentsIntoLongOptionAndPositionalArgumentTokens",
         testExpandsLongOptionValueAssignmentsIntoLongOptionAndPositionalArgumentTokens),
        ("testReturnsShortOptionTokenWhenLongOptionContainsNoCharacters",
         testReturnsShortOptionTokenWhenLongOptionContainsNoCharacters),
        ("testReturnsPositionalArgumentTokenWhenShortOptionContainsNoCharacters",
         testReturnsPositionalArgumentTokenWhenShortOptionContainsNoCharacters)
    ]
}
