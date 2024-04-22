import Combine
import Foundation

final class WeatherViewModel {
    
    // MARK: - Properties
    private var city: City
    
    @Published var location: String?
    @Published var temperature: String? = "0.0" + "С"
    @Published var hourlyWeather = [Double]()
    @Published var hours = [String]()
    
    @Published var errorMessage: String?
    
    private lazy var subscriptions = Set<AnyCancellable>()
    private var apiService = APIClient()
    
    
    // MARK: - Init
    init(city: City) {
        self.city = city
        self.location = city.name
        fetchWeather()
    }
    
    
    // MARK: - Public methods
    func getTime(for indexPath: IndexPath) -> String {
        return hours[indexPath.row]
    }
    
    func getHourlyWeather(for indexPath: IndexPath) -> Double {
        return hourlyWeather[indexPath.row]
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
                    
                    self.temperature = String(temp)
                    self.hourlyWeather = hourly
                    self.hours = time
                    
                case .failure(let failure):
                    self.errorMessage = failure.message
                }
            }
        }
    }
}
