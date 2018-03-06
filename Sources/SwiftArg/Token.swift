
internal struct Token {
    
    public enum LexType {
        case longOption
        case shortOption
        case positionalArgument
    }
    
    public let value: String
    
    public let lexType: LexType
}

extension Token: Equatable {
    
    public static func ==(left: Token, right: Token) -> Bool {
        return left.lexType == right.lexType && left.value == right.value
    }
}
