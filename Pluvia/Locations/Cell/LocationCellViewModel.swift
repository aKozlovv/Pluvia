import Combine

final class LocationCellViewModel {
 
    // MARK: - Properties
    private var city: City
    private var dataManager = CititesRepository(dataManager: CoreDataManager.shared)
    
    @Published var cityName: String!
    @Published var countryName: String!
    @Published var isFavorite: Bool = false
    
    
    // MARK: - Init
    init(city: City) {
        self.city = city
        self.cityName = city.name
        self.countryName = city.country
        
        checkIsFavorite()
    }
    
    
    // MARK: - Persistence methods
    func checkIsFavorite() {
        guard dataManager.readSingleCity(with: city.name) != nil else {
            isFavorite = false
            return
        }
        
        isFavorite = true
    }
    
    func tryAddToFavorites() {
        switch isFavorite {
            
        case true:
            dataManager.delete(city)
            isFavorite = false
            
        case false:
            dataManager.create(city)
            isFavorite = true
        }
    }
}
