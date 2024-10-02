import Foundation
import SQLite

class DatabaseManager {
    static let shared = DatabaseManager()

    private var db: Connection?

    private let users = Table("users")
    private let id = Expression<Int64>("id")
    private let username = Expression<String>("username")
    private let password = Expression<String>("password")

    private init() {
        do {
            // Ruta de la base de datos
            let documentDirectory = try FileManager.default.url(
                for: .documentDirectory,
                in: .userDomainMask,
                appropriateFor: nil,
                create: false
            )
            let fileUrl = documentDirectory.appendingPathComponent("users").appendingPathExtension("sqlite3")
            db = try Connection(fileUrl.path)
            
            // Crear tabla de usuarios
            try createTable()
            
            // Pre-poblar la base de datos si está vacía
            try prepopulateDatabase()

        } catch {
            print("Error al conectar la base de datos: \(error)")
        }
    }

    // Crear la tabla de usuarios si no existe
    private func createTable() throws {
        let createTable = users.create(ifNotExists: true) { table in
            table.column(id, primaryKey: true)
            table.column(username, unique: true)
            table.column(password)
        }
        try db?.run(createTable)
    }

    // Pre-poblar la base de datos con datos por defecto
    private func prepopulateDatabase() throws {
        // Verificar si la tabla de usuarios está vacía
        let userCount = try db?.scalar(users.count) ?? 0
        if userCount == 0 {
            // Insertar usuario por defecto
            try registerUser(username: "yoset", password: "123123")
            try registerUser(username: "admin", password: "admin123")
            print("Base de datos pre-poblada con usuarios iniciales.")
        }
    }

    // Registrar nuevo usuario
    func registerUser(username: String, password: String) throws {
        let insertUser = users.insert(self.username <- username, self.password <- password)
        try db?.run(insertUser)
    }

    // Validar usuario (login)
    func validateUser(username: String, password: String) -> Bool {
        do {
            let query = users.filter(self.username == username && self.password == password)
            if let _ = try db?.pluck(query) {
                return true
            }
        } catch {
            print("Error al validar el usuario: \(error)")
        }
        return false
    }
}
