//
//  LoginViewController.swift
//  loginApp
//
//  Created by epismac on 2/10/24.
//

import Foundation
import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var logoutButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        updateUIForLoginState()
    }

    @IBAction func loginTapped(_ sender: UIButton) {
        guard let username = usernameTextField.text, !username.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
            showAlert(message: "Por favor, ingresa tu nombre de usuario y contraseña.")
            return
        }

        // Validar usuario
        let isValidUser = DatabaseManager.shared.validateUser(username: username, password: password)
        if isValidUser {
            UserDefaults.standard.set(true, forKey: "isLoggedIn")
            showAlert(message: "Login exitoso.")
            updateUIForLoginState()
        } else {
            showAlert(message: "Nombre de usuario o contraseña incorrectos.")
        }
    }

    @IBAction func logoutTapped(_ sender: UIButton) {
        UserDefaults.standard.set(false, forKey: "isLoggedIn")
        updateUIForLoginState()
    }

    private func updateUIForLoginState() {
        let isLoggedIn = UserDefaults.standard.bool(forKey: "isLoggedIn")
        usernameTextField.isHidden = isLoggedIn
        passwordTextField.isHidden = isLoggedIn
        loginButton.isHidden = isLoggedIn
        logoutButton.isHidden = !isLoggedIn
    }

    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Atención", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
