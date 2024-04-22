import Combine
import Foundation

final class APIClient: APIService {
    
    
    // MARK: - Init
    init() {}
    
    
    // MARK: - Network methods
    func fetchCities(by name: String) async throws -> Result<Coordinates?, APIError> {
        return try await request(.cities(name: name))
    }
    
    func fetchWeather(for city: City) async throws -> Result<Weather?, APIError> {
        return try await request(.weather(lat: city.latitude, long: city.longitude))
    }
}
