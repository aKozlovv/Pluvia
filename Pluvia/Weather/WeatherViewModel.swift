import Combine

final class WeatherViewModel {
    
    private lazy var subscriptions = Set<AnyCancellable>()
    private var apiService = APIClient()
    
    init() {
        fetchWeather()
    }
    
    private func fetchWeather() {
        Task {
            do {
                let result = try await apiService.fetchWeather(for: "Berlin")
                switch result {
                case .success(let success):
                    print(success?.hourly)
                    
                case .failure(let failure):
                    print(failure.message)
                }
            }
        }
    }
    
    
}
