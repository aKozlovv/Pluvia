import Combine

final class LocationsViewModel {
    
    // MARK: - Properties
    @Published var cities = [City]()
    
    private var apiService = APIClient()
    private lazy var subscriptions = Set<AnyCancellable>()
    
    
    // MARK: - Init
    init() {
        fetchCities()
    }
    
    
    // MARK: - Private func
    private func fetchCities() {
        Task {
            do {
                let result = try await apiService.fetchCities(by: "Berlin")
                switch result {
                case .success(let success):
                    guard let data = success?.results else { return }
                    self.cities = data
                    
                case .failure(let failure):
                    print(failure.message)
                }
            }
        }
        
    }
}
