import CoreData

final class CititesRepository {
    
    // MARK: - Properties
    private var dataManager: CoreDataManager
    
    
    // MARK: - Init
    init(dataManager: CoreDataManager) {
        self.dataManager = dataManager
    }
    
    
    // MARK: - CRUD
    func create(city: City) -> Bool {
        let context = dataManager.getContext()
        let cdCity = CDCity(context: context)
        
        cdCity.name = city.name
        cdCity.country = city.country
        cdCity.lat = city.latitude
        cdCity.long = city.longitude
        
        return dataManager.saveContext()
    }
    
    func readSingleCity(by name: String) -> City? {
        let predicate = NSPredicate(format: "name == %@", name)
        
        guard let result = dataManager.fetchSingleEntity(with: predicate) as? CDCity else {
            return nil }
        
        return result.convertToCityModel()
    }
    
    func readAllCities() -> [City]? {
        guard let result = dataManager.fetchAllManagedObjects(managedObject: CDCity.self) else {
            return nil
        }
        
        return result.map { $0.convertToCityModel() }
    }
    
    func delete(city: City) -> Bool {
        let predicate = NSPredicate(format: "name == %@", city.name)
        
        guard let result = dataManager.fetchSingleEntity(with: predicate) else {
            return false }
        
        let context = dataManager.getContext()
        context.delete(result)
        
        return dataManager.saveContext()
    }
}
