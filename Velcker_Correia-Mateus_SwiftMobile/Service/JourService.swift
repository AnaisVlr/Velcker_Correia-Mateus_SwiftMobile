//
//  JourService.swift
//  Velcker_Correia-Mateus_SwiftMobile
//
//  Created by m1 on 23/03/2023.
//

import Foundation

class JourService {
  private let url = "https://velcker-correia-mateus-api-mobile.cluster-ig3.igpolytech.fr/jour"
  
    func getAllByFestivalId(token: String, id_festival: Int, completion: @escaping(Result<[Jour]?, Error>) -> Void) -> Void {
    var request = URLRequest(url: URL(string: self.url+"/festival/\(id_festival)")!)
    request.httpMethod = "GET"
    request.setValue("application/json", forHTTPHeaderField: "Content-type")
    request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
    
    let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
      guard let data = data, error == nil else {
        return completion(.failure(ServiceError.NoData))
      }
      Task {
        do {
          let decoded : [JourDTO]? = await JSONHelper.decode(data: data)
          if let decoded = decoded {
            guard let jours = JourDTO.jourDTO2Jour(data: decoded) else {
              completion(.failure(ServiceError.WrongData)); return
            }
            
            completion(.success(jours))
          } else {
            completion(.failure(ServiceError.NoData))
          }
        }
      }
    }
    dataTask.resume()
  }
  
  func create(token: String, jour: Jour, completion: @escaping(Result<Jour, Error>) -> Void) -> Void {
    var request = URLRequest(url: URL(string: self.url)!)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-type")
    request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
    
    let jsonString = "{ \"id_festival\": \"\(jour.id_festival)\", \"nom_jour\": \"\(jour.nom)\", \"ouverture\": \"\(jour.ouverture.ISO8601Format())\", \"fermeture\": \"\(jour.fermeture.ISO8601Format())\" }"
    
    guard let jsonData = jsonString.data(using: .utf8) else {return}
    request.httpBody = jsonData
    
    let dataTask = URLSession.shared.uploadTask(with: request,from: jsonData) { (data, response, error) in
      guard let data = data, error == nil else {
        return completion(.failure(ServiceError.NoData))
      }
      if let httpResponse = response as? HTTPURLResponse {
        if(httpResponse.statusCode == 201) {
          guard let j : JourDTO = JSONHelper.decodePasAsync(data: data) else {print("Erreur decode create Jour"); completion(.failure(ServiceError.WrongData)); return}
          let jour = Jour(j)
          completion(.success(jour))
        }
        else {completion(.failure(ServiceError.Failed))}
      }
      else {completion(.failure(ServiceError.Failed))}
    }
    dataTask.resume()
  }
    
  func delete(token: String, id_jour: Int, completion: @escaping(Result<Bool, Error>) -> Void) -> Void {
    var request = URLRequest(url: URL(string: self.url+"/\(id_jour)")!)
    request.httpMethod = "DELETE"
    request.setValue("application/json", forHTTPHeaderField: "Content-type")
    request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
    
    
    let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
      
      guard error == nil else {
        return completion(.failure(ServiceError.NoData))
      }
      if let httpResponse = response as? HTTPURLResponse {
        if(httpResponse.statusCode == 200) {
          completion(.success(true))
        }
        else {completion(.failure(ServiceError.Failed))}
      }
      else {completion(.failure(ServiceError.Failed))}
    }
    dataTask.resume()
  }
}
