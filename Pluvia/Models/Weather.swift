// MARK: - Weather
struct Weather: Codable {
    let latitude: Double
    let longitude: Double
    let hourly: Hourly?
    
    enum CodingKeys: String, CodingKey {
        case latitude, longitude
        case hourly
    }
}

// MARK: Hourly
struct Hourly: Codable {
    let time: [String]?
    let temperature2M: [Double]?
    let relativeHumidity2M: String?
    
    enum CodingKeys: String, CodingKey {
        case time
        case temperature2M = "temperature_2m"
        case relativeHumidity2M = "relative_humidity_2m"
    }
}
