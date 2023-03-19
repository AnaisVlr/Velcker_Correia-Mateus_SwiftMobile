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
  
  @Published var token = ""
    
  var loginDisabled: Bool {
    email.isEmpty || password.isEmpty
  }
    
  func login(completion: @escaping (Bool) -> Void){
    showProgressView = true
    Task {
      let token: String = await AuthService.tryConnect(id: email, pwd: password)
      if(token != "") { //Connexion réussie
        
        DispatchQueue.main.async { //Pour pouvoir modifier des variables Published
          self.showProgressView = false
          self.token = token
          completion(true)
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
