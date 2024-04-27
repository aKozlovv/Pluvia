import Combine
import UIKit

final class LocationsViewModel: ObservableObject {
    
    // MARK: - Properties
    @Published var cities = [City]()
    @Published var errorMessage: String?
    
    private var dataManager: CititesRepository = CititesRepository(dataManager: CoreDataManager.shared)
    private lazy var apiService = APIClient()
    private lazy var subscriptions = Set<AnyCancellable>()
    
    
    // MARK: - Init
    init() {}
    
    
    // MARK: - Bindings
    func bind(field search: AnyPublisher<String, Never>) {
        search
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.global())
            .sink {[weak self] query in
                self?.fetchCities(by: query)
            }
            .store(in: &subscriptions)
    }
    
    
    // MARK: - Methods
    func city(at indexPath: IndexPath) -> City {
        return cities[indexPath.row]
    }
    
    @discardableResult
    func create(city: City) -> Bool {
        dataManager.create(city)
    }
    
    
    // MARK: - Network
    func fetchCities(by name: String) {
        Task {
            let result = try await apiService.fetchCities(by: name)
            
            switch result {
            case .success(let success):
                guard let data = success?.results else {
                    return }
                
                self.cities = data
                
            case .failure(let failure):
                self.errorMessage = failure.message
            }
        }
    }
}
