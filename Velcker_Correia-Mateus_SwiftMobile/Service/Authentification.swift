//
//  Authentification.swift
//  Velcker_Correia-Mateus_SwiftMobile
//
//  Created by m1 on 18/03/2023.
//

import Foundation
import SwiftUI

struct JSONDecoded : Decodable {
  var iat: Int
  var email: String
  var sub: Int
  var exp: Int
  var is_admin: Bool
}

class Authentification: ObservableObject {
  @Published var isValidated = false
  
  @Published var token = ""
  @Published var id = 0
  @Published var email = ""
  @Published var is_admin = false
  
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
  
  func updateValidation(success: Bool, token: String) async {
    self.isValidated = success
    if(self.isValidated) {
      self.token = token
      
      let decodedString: [String : Any]  = JWTDecode.decode(jwtToken: token)
      let decodedData: Data = try! JSONSerialization.data(withJSONObject: decodedString)
      guard let decoded : JSONDecoded = await JSONHelper.decode(data: decodedData) else {print("Erreur lors du decode de l'authentification"); return}

      self.email = decoded.email
      self.id = decoded.sub
      self.is_admin = decoded.is_admin
      
    }
  }
}
