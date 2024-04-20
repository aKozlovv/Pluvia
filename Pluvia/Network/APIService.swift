import Foundation

protocol APIService {
    
    func fetchCities(by name: String) async throws -> Result<Coordinates?, APIError>
    
    func fetchWeather(for city: City) async throws -> Result<Weather?, APIError>
}


extension APIService {
    func request<T: Decodable>(_ endpoint: Endpoint) async throws -> Result<T?, APIError> {
        
        let (data, response) = try await URLSession.shared.data(for: endpoint.request)
        
        guard checkResponseCode(response as! HTTPURLResponse) else {
            return .failure(.failedResponse)
        }
        
        do {
            let result = try JSONDecoder().decode(T.self, from: data)
            return .success(result)
        }
        catch {
            return .failure(.invalidData)
        }
    }
    
    
    // MARK: - Private methods
    private func checkResponseCode(_ response: HTTPURLResponse) -> Bool {
        switch response.statusCode {
        case 200...299:
            return true
            
        default:
            return false
        }
    }
}
