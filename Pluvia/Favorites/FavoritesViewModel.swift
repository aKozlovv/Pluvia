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
    
    func updateData() {
        self.rawData = fetchAll()
        filtredData = rawData
    }
    
    private func filterCities(by query: String) {
        self.filtredData = []
        
        if query == "" {
            filtredData = rawData
        } else {
            rawData.forEach {
                $0.name.lowercased().contains(query) ? filtredData.append($0) : ()
            }
        }
    }
    
    private func fetchAll() -> [City] {
        guard let result = dataManager.readAll() else {
            return []
        }
        
        return result
    }
}
