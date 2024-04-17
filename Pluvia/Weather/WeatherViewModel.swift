import Combine

final class WeatherViewModel {
    
    // MARK: - Properties
    @Published var city: String
    @Published var temperature: Double = 0.0
    @Published var hourlyWeather = [Double]()
    @Published var hours = [String]()
    @Published var errorMessage: String?
    
    private lazy var subscriptions = Set<AnyCancellable>()
    private var apiService = APIClient()
    
    
    // MARK: - Init
    init(city: String) {
        self.city = city
        fetchWeather()
    }
    
    
    // MARK: - Private mthods
    private func fetchWeather() {
        Task {
            do {
                let result = try await apiService.fetchWeather(for: city)
                switch result {
                case .success(let success):
                    guard
                        let temp = success?.hourly?.temperature2M?.first,
                        let hourly = success?.hourly?.temperature2M,
                        let time = success?.hourly?.time
                    else {
                        self.errorMessage = APIError.invalidData.message
                        return
                    }
                    
                    self.temperature = temp
                    self.hourlyWeather = hourly
                    self.hours = time
                    
                case .failure(let failure):
                    print(failure.message)
                }
            }
        }
    }
}
