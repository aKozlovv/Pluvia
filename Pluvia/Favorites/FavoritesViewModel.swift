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
            .map { text -> String in text.lowercased() }
            .sink {[weak self] value in
                guard let self = self else { return }
                
                self.filtredData = []
                
                if value == "" {
                    self.filtredData = self.rawData
                }
                else {
                    for city in rawData {
                        if city.name
                            .lowercased()
                            .contains(value) {
                            filtredData.append(city)
                        }
                    }
                }
            }
            .store(in: &subscriptions)
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
