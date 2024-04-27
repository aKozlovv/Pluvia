// MARK: - Coordinates
struct Coordinates: Codable {
    let results: [City]
}

// MARK: City
struct City: Codable, Hashable {
    let name: String
    let country: String
    let latitude: Double
    let longitude: Double
}
