final class APIClient: APIService {
    
    
    // MARK: - Init
    init() {}
    
    
    // MARK: - Network methods
    func fetchCities(by name: String) async throws -> Result<Coordinates?, APIError> {
        return try await request(.cities(name: name))
    }
    
    func fetchWeather(for city: String) async throws -> Result<Weather?, APIError> {
        guard let cords = try? await getCoordinates(for: city) else {
            throw APIError.invalidURL
        }
        
        switch cords {
        case .success(let success):
            
            guard
                let lat = success?.results[0].latitude,
                let long = success?.results[0].longitude
            else { throw APIError.failedResponse }
            
            return try await request(.weather(lat: lat, long: long))
            
        case .failure(_):
            throw APIError.invalidURL
        }
    }
    
    
    // MARK: - Private methods
    private func getCoordinates(for city: String) async throws -> Result<Coordinates?, APIError> {
        return try await request(.cities(name: city))
    }
}
