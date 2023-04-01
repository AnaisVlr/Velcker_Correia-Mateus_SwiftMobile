//
//  CreneauService.swift
//  Velcker_Correia-Mateus_SwiftMobile
//
//  Created by m1 on 23/03/2023.
//

import Foundation

class CreneauService {
  private let url = "https://velcker-correia-mateus-api-mobile.cluster-ig3.igpolytech.fr/creneau"
  
  func getAllByFestivalId(token: String, id_festival: Int, completion: @escaping(Result<[Creneau]?, Error>) -> Void) -> Void {
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
          let decoded : [CreneauDTO]? = await JSONHelper.decode(data: data)
          if let decoded = decoded {
            guard let creneaux = CreneauDTO.creneauDTO2Creneau(data: decoded) else {
              completion(.failure(ServiceError.WrongData)); return
            }
            
            completion(.success(creneaux))
          } else {
            completion(.failure(ServiceError.NoData))
          }
        }
      }
    }
    dataTask.resume()
  }
  func getAllByJourId(token: String, id_jour: Int, completion: @escaping(Result<[Creneau]?, Error>) -> Void) -> Void {
    var request = URLRequest(url: URL(string: self.url+"/jour/\(id_jour)")!)
    request.httpMethod = "GET"
    request.setValue("application/json", forHTTPHeaderField: "Content-type")
    request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
    
    let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
      guard let data = data, error == nil else {
        return completion(.failure(ServiceError.NoData))
      }
      Task {
        do {
          let decoded : [CreneauDTO]? = await JSONHelper.decode(data: data)
          if let decoded = decoded {
            guard let creneaux = CreneauDTO.creneauDTO2Creneau(data: decoded) else {
              completion(.failure(ServiceError.WrongData)); return
            }
            
            completion(.success(creneaux))
          } else {
            completion(.failure(ServiceError.NoData))
          }
        }
      }
    }
    dataTask.resume()
  }
  
  func getAllByBenevoleId(token: String, id_benevole: Int, completion: @escaping(Result<[Creneau]?, Error>) -> Void) -> Void {
    var request = URLRequest(url: URL(string: self.url+"/benevole/\(id_benevole)")!)
    request.httpMethod = "GET"
    request.setValue("application/json", forHTTPHeaderField: "Content-type")
    request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
    
    let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
      guard let data = data, error == nil else {
        return completion(.failure(ServiceError.NoData))
      }
      Task {
        do {
          let decoded : [CreneauDTO]? = await JSONHelper.decode(data: data)
          if let decoded = decoded {
            guard let creneaux = CreneauDTO.creneauDTO2Creneau(data: decoded) else {
              completion(.failure(ServiceError.WrongData)); return
            }
            
            completion(.success(creneaux))
          } else {
            completion(.failure(ServiceError.NoData))
          }
        }
      }
    }
    dataTask.resume()
  }
  
  
  func create(token: String, creneau: Creneau, completion: @escaping(Result<Creneau, Error>) -> Void) -> Void {
    var request = URLRequest(url: URL(string: self.url)!)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-type")
    request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
    
    let jsonString = "{ \"id_jour\": \"\(creneau.id_jour)\", \"debut\": \"\(creneau.debut.ISO8601Format())\", \"fin\": \"\(creneau.fin.ISO8601Format())\" }"
    guard let jsonData = jsonString.data(using: .utf8) else {return}
    request.httpBody = jsonData
    
    let dataTask = URLSession.shared.uploadTask(with: request,from: jsonData) { (data, response, error) in
      guard let data = data, error == nil else {
        return completion(.failure(ServiceError.NoData))
      }
      if let httpResponse = response as? HTTPURLResponse {
        if(httpResponse.statusCode == 201) {
          guard let c : CreneauDTO = JSONHelper.decodePasAsync(data: data) else {print("Erreur decode create Creneau"); completion(.failure(ServiceError.WrongData)); return}
          let creneau = Creneau(c)
          completion(.success(creneau))
        }
        else {completion(.failure(ServiceError.Failed))}
      }
      else {completion(.failure(ServiceError.Failed))}
    }
    dataTask.resume()
  }
    
  func delete(token: String, id_creneau: Int, completion: @escaping(Result<Bool, Error>) -> Void) -> Void {
    var request = URLRequest(url: URL(string: self.url+"/\(id_creneau)")!)
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
