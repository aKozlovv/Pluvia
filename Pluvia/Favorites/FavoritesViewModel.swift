import Combine

final class FavoritesViewModel {
    
    // MARK: - Properties
    private var dataManager: CititesRepository
    private var subscriptions = Set<AnyCancellable>()
    
    private var rawData: [City] = []
    @Published private(set) var filtredData: [City] = []
    
    
    // MARK: - Init
    init(dataManager: CititesRepository) {
        self.dataManager = dataManager
        self.rawData = fetchAll()
        self.filtredData = rawData
    }
    
    
    // MARK: - Search binding
    func bind(field: AnyPublisher<String, Never>) {
        field
            .map { $0.lowercased() }
            .sink {[weak self] value in
                self?.filterCities(by: value)
            }
            .store(in: &subscriptions)
    }
    
    private func filterCities(by query: String) {
        self.filtredData = []
        
        if query == "" {
            filtredData = rawData
        } else {
            rawData.forEach { 
                if $0.name.lowercased().contains(query) { filtredData.append($0) } }
        }
    }
        
    
    // MARK: - CRUD
    func create(city: City) -> Bool {
        dataManager.create(city: city)
    }
    
    func fetchAll() -> [City] {
        guard let result = dataManager.readAllCities() else {
            return []
        }
        return result
    }
    
    func fetchCity(_ city: City) -> City? {
        dataManager.readSingleCity(by: city.name)
    }
    
    func delete(city: City) -> Bool {
        dataManager.delete(city: city)
    }
}
