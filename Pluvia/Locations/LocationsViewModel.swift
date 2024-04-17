import Combine

final class LocationsViewModel {
    
    var cities = [City]() { didSet { print(cities) } }
    
    private var apiService = APIClient()
    private lazy var subscriptions = Set<AnyCancellable>()
    
    init() {
        fetchCities()
    }
    
    private func fetchCities() {
        Task {
            do {
                let result = try await apiService.fetchCities(by: "Berlin")
                switch result {
                case .success(let success):
                    guard let data = success?.results else { return }
                    
                case .failure(let failure):
                    print(failure.message)
                }
            }
        }
        
    }
}
