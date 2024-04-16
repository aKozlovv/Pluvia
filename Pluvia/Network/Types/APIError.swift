enum APIError: Error {
    case unknown
    case badConnection
    case invalidURL
    case failedResponse
    case invalidData
    
    var message: String {
        switch self {
        case .unknown:
            return "Weather service unavialable"
            
        case .badConnection:
            return "Unable to perform request, chek your internet connection"
            
        case .invalidURL:
            return "Invalid request, check your search query"
            
        case .failedResponse:
            return "Weather service unavialable"
            
        case .invalidData:
            return "Weather cannot be displayed"
        }
    }
}
