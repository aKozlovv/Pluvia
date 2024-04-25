import Foundation

enum Endpoint {
    
    // MARK: - Cases
    case cities(name: String)
    case weather(lat: Double, long: Double)
    
    
    // MARK: - Properties
    var request: URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        return request
    }
    
    
    var url: URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = host
        components.path = path
        components.queryItems = items
        
        return components.url!
    }
    
    
    private var path: String {
        switch self {
        case .cities:
            return "/v1/search"
            
        case .weather:
            return "/v1/forecast"
        }
    }
    
    
    private var host: String {
        switch self {
        case .cities:
            return "geocoding-api.open-meteo.com"
            
        case .weather:
            return "api.open-meteo.com"
        }
    }
    
    
    private var method: HTTPMethod {
        switch self {
        case .cities:
            return .get
            
        case .weather:
            return .get
        }
    }
    
    
    // MARK: - All needed weather queries
    private var items: [URLQueryItem] {
        switch self {
        case .cities(let city):
            return [
                URLQueryItem(name: Query.name.rawValue, value: city),
                URLQueryItem(name: Query.count.rawValue, value: "10"),
                URLQueryItem(name: Query.language.rawValue, value: "en"),
                URLQueryItem(name: Query.format.rawValue, value: "json")
            ]
            
        case .weather(let lat, let long):
            return [
                URLQueryItem(name: Query.latitude.rawValue, value: String(lat)),
                URLQueryItem(name: Query.longitude.rawValue, value: String(long)),
                URLQueryItem(name: Query.hourly.rawValue, value: "temperature_2m"),
                URLQueryItem(name: Query.daily.rawValue, value: "temperature_2m_max,temperature_2m_min,uv_index_max,wind_speed_10m_max"),
                URLQueryItem(name: Query.current.rawValue, value: "relative_humidity_2m")
            ]
        }
    }
    
    
    // MARK: - Query items enum
    private enum Query: String {
        case latitude
        case longitude
        case hourly
        case daily
        case current
        
        case name
        case count
        case language
        case format
    }
}
