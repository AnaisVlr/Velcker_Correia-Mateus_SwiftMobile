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
//      let dataString = String(data: data, encoding: .utf8)!
//      print(dataString)
      guard let decoded : AuthDTO = await JSONHelper.decode(data: data) else {print("Erreur lors du decode de l'authentification"); return ""}
      
      token = decoded.access_token
      
    }catch{
      print("Erreur lors de la connexion")
      print(error)
    }
    return token
  }
  
  static public func create(token: String, email: String, nom: String, prenom: String, password: String, completion: @escaping(Result<Benevole, Error>) -> Void) -> Void {
    var request = URLRequest(url: URL(string: self.authUrl.absoluteString+"/signup")!)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-type")
    request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
    
    let jsonString = "{ \"email_benevole\": \(email)\", \"nom_benevole\": \"\(nom)\", \"prenom_benevole\": \"\(prenom)\", \"password_benevole\": \"\(password)\"}"
    guard let jsonData = jsonString.data(using: .utf8) else {return}
    request.httpBody = jsonData
    
    let dataTask = URLSession.shared.uploadTask(with: request,from: jsonData) { (data, response, error) in
      guard let data = data, error == nil else {
        return completion(.failure(ServiceError.NoData))
      }
      if let httpResponse = response as? HTTPURLResponse {
        if(httpResponse.statusCode == 201) {
          guard let b : BenevoleDTO = JSONHelper.decodePasAsync(data: data) else {print("Erreur decode create Benevole"); completion(.failure(ServiceError.WrongData)); return}
          let benevole = Benevole(b)
          completion(.success(benevole))
        }
        else {completion(.failure(ServiceError.Failed))}
      }
      else {completion(.failure(ServiceError.Failed))}
    }
    dataTask.resume()
  }
  
}
