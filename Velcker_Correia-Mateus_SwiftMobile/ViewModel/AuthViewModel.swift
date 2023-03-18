//
//  AuthViewModel.swift
//  Velcker_Correia-Mateus_SwiftMobile
//
//  Created by m1 on 18/03/2023.
//

import Foundation

class AuthViewModel: ObservableObject {
  @Published var email: String = "dorian.752@live.fr"
  @Published var password: String = "123"
  @Published var showProgressView = false
  @Published var error: Authentification.AuthentificationError?
    
  var loginDisabled: Bool {
    email.isEmpty || password.isEmpty
  }
    
  func login(completion: @escaping (Bool) -> Void){
    showProgressView = true
    Task {
      let result: String = await AuthService.tryConnect(id: email, pwd: password)
      if(result != "") { //Connexion réussie
        completion(true)
        DispatchQueue.main.async { //Pour pouvoir modifier des variables Published
          self.showProgressView = false
        }
      }
      else {
        DispatchQueue.main.async { //Pour pouvoir modifier des variables Published
          self.error = .invalidCredentials
        }
        completion(false)
      }
      
      
    }
  }
}
