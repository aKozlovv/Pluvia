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
    
    
    // MARK: - CRUD
    func create<E>(proccess: (_ object: E) -> Void) -> Bool {
        proccess(NSEntityDescription.insertNewObject(forEntityName: "\(E.self)", into: viewContext) as! E)
        return saveContext()
    }
    
    func read<E>(proccess: ((_ fetchRequest: NSFetchRequest<NSFetchRequestResult>) -> Void)?) -> [E] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "\(E.self)")
        
        proccess?(fetchRequest)
        
        do {
            return try viewContext.fetch(fetchRequest) as! [E]
        }
        catch let error {
            fatalError(error.localizedDescription)
        }
    }
    
    func delete<E>(proccess: ((_ fetchRequest: NSFetchRequest<NSFetchRequestResult>) -> Void)?, deletedObjects: ((_ objects: [E]) -> Void)?) -> Bool {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "\(E.self)")
        
        do {
            let objects = try viewContext.fetch(fetchRequest) as! [E]
            
            deletedObjects?(objects)
            
            for object in objects {
                viewContext.delete(object as! NSManagedObject)
            }
            
            return saveContext()
        }
        catch let error {
            fatalError(error.localizedDescription)
        }
    }
    
    
    // MARK: - Context managment
    func getContext() -> NSManagedObjectContext {
        return viewContext
    }
    
    @discardableResult
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
