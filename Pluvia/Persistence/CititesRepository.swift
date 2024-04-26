import CoreData

final class CititesRepository {
    
    // MARK: - Properties
    private var dataManager: CoreDataManager
    
    
    // MARK: - Init
    init(dataManager: CoreDataManager) {
        self.dataManager = dataManager
    }
    
    
    // MARK: - CRUD
    @discardableResult
    func create(_ city: City) -> Bool {
        return dataManager.create { (object: CDCity) in
            object.name = city.name
            object.country = city.country
            object.lat = city.latitude
            object.long = city.longitude
        }
    }
    
    func readAll() -> [City]? {
        let result: [CDCity] = dataManager.read { _ in }
        return result.map { $0.convertToCityModel() }
    }
    
    func readSingleCity(with name: String) -> City? {
        readAll()?.first(where: { city in city.name == name })
    }
    
    @discardableResult
    func delete(_ city: City) -> Bool {
        return dataManager.delete { request in
            request.predicate = NSPredicate(format: "name == %@", city.name)
            
        } deletedObjects: { (objects: [CDCity]) in
            debugPrint("Deleted: \(objects.count) object, there are: \(objects)")
        }
    }
}
