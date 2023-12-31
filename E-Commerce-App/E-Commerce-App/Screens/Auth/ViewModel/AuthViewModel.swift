//
//  AuthViewModel.swift
//  E-Commerce-App
//
//  Created by Yaşar Duman on 23.11.2023.
//

import FirebaseAuth

final class AuthViewModel {
    lazy var firebaseAuthManager = FirebaseAuthManager()
    // MARK: - Login
    func login(email: String, password: String, completion: @escaping () -> Void) {
        firebaseAuthManager.signIn(email: email, password: password) {
            completion()
        } onError: { error in
            print(error.localizedDescription)
        }
    }
    
    // MARK: - Register
    func register(userName: String, email: String, password: String, completion: @escaping () -> Void) {
        firebaseAuthManager.register(userName: userName,
                                     email: email,
                                     password: password) {
            completion()
        } onError: { error in
            print(error)
        }

    }
    
    // MARK: - ForgotPassword
    func resetPassword(email: String, completion: @escaping (Bool, String) -> Void) {
        guard !email.isEmpty else {
            completion(false, "E-mail cannot be blank.")
            return
        }
        
        firebaseAuthManager.resetPassword(email: email) {
            completion(true, "Please check your e-mail to reset your password.")
        } onError: { error in
            completion(false, error)
        }
    }
    
    // MARK: - Change Password
    func changePassword(password: String, completion: @escaping (Bool, String) -> Void) {
        guard !password.isEmpty else {
            completion(false, "Parola alanı boş bırakılamaz.")
            return
        }
        Auth.auth().currentUser?.updatePassword(to: password) { (error) in
            if let error = error {
                // Şifreyenileme işlemi başarısız
                completion(false, "Şifre Güncellendi: \(error.localizedDescription)")
            } else {
                // Şifre yenileme başarılı
                completion(true, "Şifreniz Güncellendi")
            }
        }
    }
    
    func signInGoogle(credential: AuthCredential, username: String, completion: @escaping () -> Void) {
        firebaseAuthManager.signInWithCredential(credential: credential, username: username) {
            completion()
        } onError: { error in
            print(error)
        }
    }
    
}
