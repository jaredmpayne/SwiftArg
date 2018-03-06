
internal class Option {
    
    public init(names: [String], maxValueCount: UInt = 0) {
        self.names = names
        self.maxValueCount = maxValueCount
    }
    
    public let names: [String]
    
    public let maxValueCount: UInt
    
    public var isRaised: Bool = false
    
    public private(set) var values: [String] = []
    
    public func add(value: String) -> Bool {
        guard self.values.count < self.maxValueCount else { return false }
        self.values.append(value)
        return true
    }
}
