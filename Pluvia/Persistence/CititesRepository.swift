import CoreData

final class CititesRepository {
    
    // MARK: - Properties
    private var dataManager: CoreDataManager
    
    
    // MARK: - Init
    init(dataManager: CoreDataManager) {
        self.dataManager = dataManager
    }
    
    
    // MARK: - CRUD
    func create(_ city: City) -> Bool {
        return dataManager.create { (object: CDCity) in
            object.name = city.name
            object.country = city.country
            object.lat = city.latitude
            object.long = city.longitude
        }
    }
}
