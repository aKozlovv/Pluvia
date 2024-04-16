@propertyWrapper
struct Formatted {
    
    /// universal formatting function
    var block: (String) -> String
    
    var wrappedValue: String = "" {
        didSet {
            wrappedValue = block(wrappedValue)
        }
    }
}
