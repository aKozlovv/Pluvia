import Combine

final class APIClient: APIService {
    
    // MARK: - Init
    init() {}
    
    
    // MARK: - Network methods
    func fetchCities(by name: String) throws -> AnyPublisher<Coordinates?, APIError> {
        request(.cities(name: name))
    }
    
    func fetchWeather(for city: String) throws -> AnyPublisher<Weather?, APIError> {
        request(.weather)
    }
}
