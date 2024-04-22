import Combine

final class WeatherCellViewModel {
    
    @Published var time: String?
    @Published var weather: String?
    
    init(time: String, weather: Double) {
        self.time = String.getTime(from: time)
        self.weather = String(weather)
    }
}
