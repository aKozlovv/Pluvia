import CoreData

final class CoreDataManager {
    
    // MARK: - Singleton
    static let shared = CoreDataManager()
    
    private init() {}
    
    
    // MARK: - Properties
    private var viewContext: NSManagedObjectContext { return persistentContainer.viewContext }
    
    
    // MARK: - CRUD
    
    
    
    
    
    // MARK: - CoreData stack
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Pluvia")
        
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func saveContext () {
        let context = persistentContainer.viewContext
        
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
