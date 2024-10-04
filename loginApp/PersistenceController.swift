import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    let container: NSPersistentContainer

    init() {
        container = NSPersistentContainer(name: "loginApp") // Cambia "loginApp" al nombre que diste en tu modelo .xcdatamodeld
        container.loadPersistentStores { (description, error) in
            if let error = error as NSError? {
                fatalError("Error al cargar Core Data: \(error), \(error.userInfo)")
            }
        }
    }

    func saveContext() {
        let context = container.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Error al guardar en CoreData: \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
