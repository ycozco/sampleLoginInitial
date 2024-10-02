//
//  ContentView.swift
//  loginApp
//
//  Created by epismac on 2/10/24.
//

import SwiftUI

struct ContentView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var isLoggedIn: Bool = UserDefaults.standard.bool(forKey: "isLoggedIn")
    @State private var showingAlert: Bool = false
    @State private var alertMessage: String = ""

    var body: some View {
        VStack {
            if isLoggedIn {
                //VISTA LOGIN SEPARAR EN OTRO ARCHHIVO
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
                    Alert(title: Text("Atención"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                }
            }
        }
        .padding()
    }

    // Función para manejar el login
    func login() {
        if username.isEmpty || password.isEmpty {
            alertMessage = "Por favor, completa ambos campos."
            showingAlert = true
            return
        }

        let isValidUser = DatabaseManager.shared.validateUser(username: username, password: password)
        if isValidUser {
            UserDefaults.standard.set(true, forKey: "isLoggedIn")
            isLoggedIn = true
            alertMessage = "Login exitoso."
        } else {
            alertMessage = "Nombre de usuario o contraseña incorrectos."
            showingAlert = true
        }
    }

    // Función para manejar el logout
    func logout() {
        UserDefaults.standard.set(false, forKey: "isLoggedIn")
        isLoggedIn = false
        username = ""
        password = ""
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

