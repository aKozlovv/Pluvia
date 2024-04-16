import Foundation
import Combine

protocol APIService {
    
    func fetchCities(by name: String) throws -> AnyPublisher<Coordinates?,APIError>
    
    func fetchWeather(for city: String) throws -> AnyPublisher<Weather?, APIError>
}


extension APIService {
    func request<T: Codable>(_ endpoint: Endpoint) -> AnyPublisher<T,APIError> {
        return URLSession.shared.dataTaskPublisher(for: endpoint.url)
            .retry(1)
            .tryMap({ data, response -> T in
                guard
                    let response = response as? HTTPURLResponse,
                    (200..<300).contains(response.statusCode)
                else {
                    throw APIError.failedResponse
                }
                
                do {
                    return try JSONDecoder().decode(T.self, from: data)
                }
                catch {
                    print("Unable to decode \(error)")
                    throw APIError.invalidData
                }
            })
            .mapError({ error -> APIError in
                switch error {
                case let apiError as APIError:
                    return apiError
                    
                case URLError.notConnectedToInternet:
                    return APIError.badConnection
                    
                default:
                    return APIError.failedResponse
                }
            })
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
        
    }
}
