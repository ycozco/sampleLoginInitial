import CoreData
import SwiftUI

class DatabaseManager {
    static let shared = DatabaseManager()

    var context: NSManagedObjectContext
    //typealias AppUser = User
    // Inicializar con el contexto pasado desde el entorno
    init(context: NSManagedObjectContext = PersistenceController.shared.container.viewContext) {
        self.context = context
        
        if fetchUsers().isEmpty {
            prepopulateDatabase()
        }
    }

    // Registrar nuevo usuario
    func registerUser(username: String, password: String) {
        let newUser = AppUser(context: context)
        newUser.username = username
        newUser.password = password
        
        saveContext()
    }

    // Validar usuario (login)
    func validateUser(username: String, password: String) -> Bool {
        let fetchRequest: NSFetchRequest<AppUser> = AppUser.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "username == %@ AND password == %@", username, password)
        
        do {
            let users = try context.fetch(fetchRequest)
            return !users.isEmpty
        } catch {
            print("Error al buscar usuarios: \(error)")
            return false
        }
    }

    // Obtener todos los usuarios
    func fetchUsers() -> [AppUser] {
        let fetchRequest: NSFetchRequest<AppUser> = AppUser.fetchRequest()
        
        do {
            return try context.fetch(fetchRequest)
        } catch {
            print("Error al buscar usuarios: \(error)")
            return []
        }
    }

    // Pre-poblar la base de datos con un usuario predeterminado
    private func prepopulateDatabase() {
        registerUser(username: "yoset", password: "123123")
        registerUser(username: "admin", password: "admin123")
        print("Base de datos pre-poblada con usuarios iniciales.")
    }

    // Guardar cambios en el contexto
    private func saveContext() {
        do {
            try context.save()
        } catch {
            print("Error al guardar en CoreData: \(error)")
        }
    }
}
