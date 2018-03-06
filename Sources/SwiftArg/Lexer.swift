
internal class Lexer {
    
    public init() { }
    
    public func lex(arguments: [String]) -> [Token] {
        return self.expand(arguments: arguments).map { self.lex(argument: $0) }
    }
    
    public func expand(arguments: [String]) -> [String] {
        return arguments.flatMap { $0.split(separator: "=", maxSplits: 1).map { String($0) } }
    }
    
    public func lex(argument: String) -> Token {
        return self.lexAsLongOption(argument: argument)
            ?? self.lexAsShortOption(argument: argument)
            ?? self.lexAsPositionalArgument(argument: argument)
    }
    
    private func lexAsLongOption(argument: String) -> Token? {
        guard argument.count > 2 && argument.starts(with: "--") else { return nil }
        return Token(value: argument, lexType: .longOption)
    }
    
    private func lexAsShortOption(argument: String) -> Token? {
        guard argument.count > 1 && argument.starts(with: "-") else { return nil }
        return Token(value: argument, lexType: .shortOption)
    }
    
    private func lexAsPositionalArgument(argument: String) -> Token {
        return Token(value: argument, lexType: .positionalArgument)
    }
}
