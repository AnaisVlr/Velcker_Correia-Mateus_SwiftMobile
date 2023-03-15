//
//  AuthService.swift
//  Velcker_Correia-Mateus_SwiftMobile
//
//  Created by etud on 14/03/2023.
//
import Foundation

struct AuthDTO : Decodable {
  var access_token: String
}

class AuthService{
  private static let authUrl = URL(string: "https://velcker-correia-mateus-api-mobile.cluster-ig3.igpolytech.fr/auth")!
  
  static public func tryConnect(id: String, pwd: String) async {
    let jsonString = "{ \"email_benevole\": \(id), \"password_benevole\": \(pwd) }"
    guard let jsonData = jsonString.data(using: .utf8) else {return}
    
    var request = URLRequest(url: self.authUrl)
    request.httpMethod = "POST"
    request.httpBody = jsonData
    request.setValue("application/json", forHTTPHeaderField: "Content-type")
    //request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
    
    do{
      let (data, _) = try await URLSession.shared.upload(for: request, from: jsonData)
      print("Anais au secours ")
      guard let decoded : AuthDTO = await JSONHelper.decode(data: data) else {print("marche pô"); return}
      print(decoded.access_token)
    }catch{
      print("Erreur lors de la connexion")
    }
  }
}
