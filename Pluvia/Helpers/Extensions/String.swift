extension String {
    
    static func getTime(from string: String) -> String {
        var result = string
        
        if let tRange = string.range(of: "T") {
            result.removeSubrange(string.startIndex...tRange.lowerBound)
        }
        
        return result
    }
}

