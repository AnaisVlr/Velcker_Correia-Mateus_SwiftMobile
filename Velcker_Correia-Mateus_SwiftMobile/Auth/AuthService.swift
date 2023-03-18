//
//  AuthService.swift
//  Velcker_Correia-Mateus_SwiftMobile
//
//  Created by etud on 14/03/2023.
//
import Foundation

struct AuthDTO : Codable {
  var access_token: String
}

class AuthService{
  private static let authUrl = URL(string: "https://velcker-correia-mateus-api-mobile.cluster-ig3.igpolytech.fr/auth")!
  
  static public func tryConnect(id: String, pwd: String) async -> String {
    let jsonString = "{ \"email_benevole\": \"\(id)\", \"password_benevole\": \"\(pwd)\" }"
    guard let jsonData = jsonString.data(using: .utf8) else {return ""}
    
    var request = URLRequest(url: URL(string: self.authUrl.absoluteString+"/signin")!)
    request.httpMethod = "POST"
    request.httpBody = jsonData
    request.setValue("application/json", forHTTPHeaderField: "Content-type")
    //    request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
    
    var token = ""
    do{
      let (data, _) = try await URLSession.shared.upload(for: request, from: jsonData)
      //let dataString = String(data: data, encoding: .utf8)!
      guard let decoded : AuthDTO = await JSONHelper.decode(data: data) else {print("Erreur lors du decode de l'authentification"); return ""}
      
      token = "Bearer "+decoded.access_token
    }catch{
      print("Erreur lors de la connexion")
      print(error)
    }
    return token
  }
}
