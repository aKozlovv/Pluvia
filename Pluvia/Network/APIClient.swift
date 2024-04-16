import Combine

final class APIClient: APIService {
    
    // MARK: - Properties
    private var subscriptions = Set<AnyCancellable>()
    
    // MARK: - Init
    init() {}
    
    
    // MARK: - Network methods
    func fetchCities(by name: String) throws -> AnyPublisher<Coordinates?, APIError> {
        request(.cities(name: name))
    }
    
    func fetchWeather(for city: String) throws -> AnyPublisher<Weather?, APIError> {
        var error: APIError?
        var lat: Double?
        var long: Double?
        
        guard let cords = try? fetchCords(for: city) else { throw APIError.invalidURL }
        
        cords.sink { completion in
            switch completion {
                
            case .finished:
                ()
            case .failure(let failure):
                error = failure
            }
        } receiveValue: { cords in
            lat = cords?.results[0].latitude
            long = cords?.results[0].longitude
        }
        .store(in: &subscriptions)
        
        if error == nil {
            return request(.weather(lat: lat!, long: long!))
        }
        else {
            throw error!
        }
    }
    
    private func fetchCords(for city: String) throws -> AnyPublisher<Coordinates?, APIError> {
        request(.cities(name: city))
    }
}
