
/// Parses command line arguments into raisable options with values assigned to them.
public class Parser {
    
    // MARK: Creating a Parser
    
    /// Creates a new `Parser`.
    public init() { }
    
    // MARK: Adding Options to the Parser
    
    private var optionMap: [String: Option] = [:]
    
    /// Adds an option to the `Parser`.
    ///
    /// If an option name conflicts with the name of a previously added option, the name
    /// defaults to the last option added with that name.
    ///
    /// - parameter names: The option names.
    /// - parameter maxValueCount: The maximum number of values that can be added to the option.
    public func addOption(names: [String], maxValueCount: UInt = 0) {
        let option = Option(names: names, maxValueCount: maxValueCount)
        option.names.forEach { self.optionMap[$0] = option }
    }
    
    // MARK: Inspecting Parse Results
    
    /// The argument passed as the executable.
    ///
    /// - returns: The executable argument.
    public private(set) var executableArgument: String = ""
    
    /// The arguments passed to the parser that were unrecognized.
    ///
    /// - returns: The unrecognized arguments.
    public private(set) var unrecognizedArguments: [String] = []
    
    /// Checks if the `Parser` contains a raised option with the given name.
    ///
    /// - parameter name: The option name.
    ///
    /// - returns: `true` if the `Parser` has a raised option with the name, `false` otherwise.
    public func hasRaisedOption(named name: String) -> Bool {
        return self.optionMap[name]?.isRaised ?? false
    }
    
    /// Returns the values of the option with the given name.
    ///
    /// - parameter name: The option name.
    ///
    /// - returns: The option values, or `nil` if the option was not found.
    public func valuesOfOption(named name: String) -> [String]? {
        return self.optionMap[name]?.values ?? nil
    }
    
    // MARK: Parsing Command Line Arguments
    
    /// Parses the program arguments.
    ///
    /// - parameter arguments: The arguments.
    public func parse(arguments: [String]) {
        guard !arguments.isEmpty else { return }
        self.executableArgument = arguments.first!
        Lexer().lex(arguments: [String](arguments[1...])).forEach { self.parse(token: $0) }
    }
    
    private func parse(token: Token) {
        switch token.lexType {
        case .longOption:
            self.parseAsLongOption(token: token)
        case .shortOption:
            self.parseAsShortOption(token: token)
        case .positionalArgument:
            self.parseAsPositionalArgument(token: token)
        }
    }
    
    private func parseAsLongOption(token: Token) {
        self.raiseOption(named: String(token.value.dropFirst(2)))
    }
    
    private func parseAsShortOption(token: Token) {
        let names = token.value.dropFirst().map { String($0) }
        names.forEach { self.raiseOption(named: $0) }
    }
    
    private var lastRaisedOption: Option?
    
    private func raiseOption(named name: String) {
        guard let option = self.optionMap[name] else {
            self.unrecognizedArguments.append(name.count > 1 ? "--" + name : "-" + name)
            return
        }
        self.lastRaisedOption = option
        option.isRaised = true
    }
    
    private func parseAsPositionalArgument(token: Token) {
        guard let option = self.lastRaisedOption, option.add(value: token.value) else {
            self.unrecognizedArguments.append(token.value)
            return
        }
    }
}

