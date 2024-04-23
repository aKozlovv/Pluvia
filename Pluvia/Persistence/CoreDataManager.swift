import CoreData

final class CoreDataManager {
    
    // MARK: - Singleton
    static let shared = CoreDataManager()
    
    private init() {}
    
    
    // MARK: - Properties
    private var viewContext: NSManagedObjectContext { return persistentContainer.viewContext }
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Pluvia")
        
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        
        return container
    }()
    
    
    // MARK: - Methods
    func fetchSingleEntity<E: NSManagedObject>(with predicate: NSPredicate) -> E? {
        let fetchRequest = NSFetchRequest<E>()
        fetchRequest.predicate = predicate
        fetchRequest.entity = E.entity()
        
        do {
            let result = try CoreDataManager.shared.viewContext.fetch(fetchRequest).first
            
            guard result != nil else { return nil }
            return result
        }
        catch let error {
            print(error)
            return nil
        }
    }
    
    func fetchAllManagedObjects<E: NSManagedObject>(managedObject: E.Type) -> [E]? {
        do {
            guard let result = try viewContext.fetch(managedObject.fetchRequest()) as? [E] else { return nil }
            return result
        }
        catch let error {
            print(error)
        }
        return nil
    }
    
    
    // MARK: - Context managment
    func getContext() -> NSManagedObjectContext {
        return viewContext
    }
    
    func saveContext() -> Bool {
        do {
            try viewContext.save()
            return true
        }
        catch {
            print(error.localizedDescription)
            return false
        }
    }
}
