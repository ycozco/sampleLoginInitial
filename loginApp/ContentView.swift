import SwiftUI

struct ContentView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var isLoggedIn: Bool = UserDefaults.standard.bool(forKey: "isLoggedIn")
    @State private var showingAlert: Bool = false
    @State private var alertMessage: String = ""

    @Environment(\.managedObjectContext) private var viewContext

    var body: some View {
        VStack {
            if isLoggedIn {
                // Vista de bienvenida al usuario
                Text("Bienvenido \(username)")
                    .font(.largeTitle)
                    .padding()

                Button(action: {
                    logout()
                }) {
                    Text("Logout")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.red)
                        .cornerRadius(10)
                }
                .padding()
            } else {
                // Vista de login
                Text("Login")
                    .font(.largeTitle)
                    .padding()

                TextField("Nombre de usuario", text: $username)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(10)
                    .padding(.bottom, 10)

                SecureField("Contraseña", text: $password)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(10)
                    .padding(.bottom, 20)

                Button(action: {
                    login()
                }) {
                    Text("Iniciar Sesión")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding()
                .alert(isPresented: $showingAlert) {
                    Alert(title: Text("Atención"), message: Text(alertMessage
