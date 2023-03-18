//
//  Authentification.swift
//  Velcker_Correia-Mateus_SwiftMobile
//
//  Created by m1 on 18/03/2023.
//

import Foundation
import SwiftUI

class Authentification: ObservableObject {
  @Published var isValidated = false
  
  enum AuthentificationError: Error, Identifiable {
    case invalidCredentials
    var id: String {
      self.localizedDescription
    }
    var errorDescription: String? {
      switch self {
      case .invalidCredentials:
        return ("Mauvais identifiants, veuillez réessayer")
      }
    }
  }
  
  func updateValidation(success: Bool) {
    withAnimation{
      DispatchQueue.main.async {
        self.isValidated = success
      }
    }
  }
}
