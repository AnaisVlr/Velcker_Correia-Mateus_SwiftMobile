//
//  BenevoleService.swift
//  Velcker_Correia-Mateus_SwiftMobile
//
//  Created by Pain des bites on 27/03/2023.
//

import Foundation

class BenevoleService{
  private let url = "https://velcker-correia-mateus-api-mobile.cluster-ig3.igpolytech.fr/benevole"
  
  func getAll(token: String, completion: @escaping(Result<[Benevole]?, Error>) -> Void) -> Void {
    var request = URLRequest(url: URL(string: self.url)!)
    request.httpMethod = "GET"
    request.setValue("application/json", forHTTPHeaderField: "Content-type")
    request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
    
    let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
      guard let data = data, error == nil else {
        return completion(.failure(ServiceError.NoData))
      }
      Task {
        do {
          let decoded : [BenevoleDTO]? = await JSONHelper.decode(data: data)
          if let decoded = decoded {
            guard let benevoles = BenevoleDTO.benevoleDTO2Benevole(data: decoded) else {
              completion(.failure(ServiceError.WrongData)); return
            }
            
            completion(.success(benevoles))
          } else {
            completion(.failure(ServiceError.NoData))
          }
        }
      }
    }
    dataTask.resume()
  }
  
  func getByFestival(token: String, id_festival : Int, completion: @escaping(Result<[Benevole]?, Error>) -> Void) -> Void {
    var request = URLRequest(url: URL(string: self.url + "/festival/\(id_festival)")!)
    request.httpMethod = "GET"
    request.setValue("application/json", forHTTPHeaderField: "Content-type")
    request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
    
    let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
      guard let data = data, error == nil else {
        return completion(.failure(ServiceError.NoData))
      }
      Task {
        do {
          let decoded : [BenevoleDTO]? = await JSONHelper.decode(data: data)
          if let decoded = decoded {
            guard let benevoles = BenevoleDTO.benevoleDTO2Benevole(data: decoded) else {
              completion(.failure(ServiceError.WrongData)); return
            }
            
            completion(.success(benevoles))
          } else {
            completion(.failure(ServiceError.NoData))
          }
        }
      }
    }
    dataTask.resume()
  }
  
  func getByZoneAndCreneau(token: String, id_zone : Int, id_creneau: Int, completion: @escaping(Result<[Benevole]?, Error>) -> Void) -> Void {
    var request = URLRequest(url: URL(string: self.url + "/zone/\(id_zone)/creneau/\(id_creneau)")!)
    request.httpMethod = "GET"
    request.setValue("application/json", forHTTPHeaderField: "Content-type")
    request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
    
    let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
      guard let data = data, error == nil else {
        return completion(.failure(ServiceError.NoData))
      }
      Task {
        do {
          let decoded : [BenevoleDTO]? = await JSONHelper.decode(data: data)
          if let decoded = decoded {
            guard let benevoles = BenevoleDTO.benevoleDTO2Benevole(data: decoded) else {
              completion(.failure(ServiceError.WrongData)); return
            }
            
            completion(.success(benevoles))
          } else {
            completion(.failure(ServiceError.NoData))
          }
        }
      }
    }
    dataTask.resume()
  }
  
  func getCountByZoneAndCreneau(token: String, id_zone : Int, id_creneau: Int, completion: @escaping(Result<Int?, Error>) -> Void) -> Void {
    var request = URLRequest(url: URL(string: self.url + "/zone/\(id_zone)/creneau/\(id_creneau)/nbbenevole")!)
    request.httpMethod = "GET"
    request.setValue("application/json", forHTTPHeaderField: "Content-type")
    request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
    
    let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
      guard let data = data, error == nil else {
        return completion(.failure(ServiceError.NoData))
      }
      Task {
        do {
          let decoded : Int? = await JSONHelper.decode(data: data)
          if let decoded = decoded {
            completion(.success(decoded))
          } else {
            completion(.failure(ServiceError.NoData))
          }
        }
      }
    }
    dataTask.resume()
  }
  
  func getCountByCreneau(token: String, id_creneau: Int, completion: @escaping(Result<Int?, Error>) -> Void) -> Void {
    var request = URLRequest(url: URL(string: self.url + "/creneau/\(id_creneau)/nbbenevole")!)
    request.httpMethod = "GET"
    request.setValue("application/json", forHTTPHeaderField: "Content-type")
    request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
    
    let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
      guard let data = data, error == nil else {
        return completion(.failure(ServiceError.NoData))
      }
      Task {
        do {
          let decoded : Int? = await JSONHelper.decode(data: data)
          if let decoded = decoded {
            completion(.success(decoded))
          } else {
            completion(.failure(ServiceError.NoData))
          }
        }
      }
    }
    dataTask.resume()
  }
  
  func getNecessaireByCreneau(token: String, id_creneau: Int, completion: @escaping(Result<Int?, Error>) -> Void) -> Void {
    var request = URLRequest(url: URL(string: self.url + "/creneau/\(id_creneau)/nbnecessaire")!)
    request.httpMethod = "GET"
    request.setValue("application/json", forHTTPHeaderField: "Content-type")
    request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
    
    let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
      guard let data = data, error == nil else {
        return completion(.failure(ServiceError.NoData))
      }
      Task {
        do {
          let decoded : Int? = await JSONHelper.decode(data: data)
          if let decoded = decoded {
            completion(.success(decoded))
          } else {
            completion(.failure(ServiceError.NoData))
          }
        }
      }
    }
    dataTask.resume()
  }
  
  
  func getByEmail(token: String, email: String, completion: @escaping(Result<Benevole?, Error>) -> Void) -> Void{
    var request = URLRequest(url: URL(string: self.url + "/email/\(email)")!)
    request.httpMethod = "GET"
    request.setValue("application/json", forHTTPHeaderField: "Content-type")
    request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
    
    let dataTask = URLSession.shared.dataTask(with: request) {
      (data, response, error) in
      guard let data = data, error == nil else{
        return completion(.failure(ServiceError.NoData))
      }
      
      Task{
        do{
          let decoded : BenevoleDTO? = await JSONHelper.decode(data: data)
          if let decoded = decoded {
            guard let benevole = BenevoleDTO.benevoleDTO2Benevole(data: [decoded]) else {
              completion(.failure(ServiceError.WrongData))
              return
            }
            completion(.success(benevole.first))
          }else {
            completion(.failure(ServiceError.NoData))
          }
        }
      }
    }
    dataTask.resume()
  }
  
  func modify(token: String, benevole: Benevole, completion: @escaping(Result<Benevole, Error>) -> Void) -> Void {
    var request = URLRequest(url: URL(string: self.url)!)
    request.httpMethod = "PUT"
    request.setValue("application/json", forHTTPHeaderField: "Content-type")
    request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
    
    let jsonString = "{ \"id_benevole\": \"\(benevole.id)\", \"prenom_benevole\": \"\(benevole.prenom)\", \"nom_benevole\": \"\(benevole.nom)\", \"email_benevole\": \"\(benevole.email)\"}"
    guard let jsonData = jsonString.data(using: .utf8) else {return}
    request.httpBody = jsonData
    
    let dataTask = URLSession.shared.uploadTask(with: request,from: jsonData) { (data, response, error) in
      guard let data = data, error == nil else {
        return completion(.failure(ServiceError.NoData))
      }
      if let httpResponse = response as? HTTPURLResponse {
        if(httpResponse.statusCode == 200) {
          guard let b : BenevoleDTO = JSONHelper.decodePasAsync(data: data) else {print("Erreur decode update Benevole"); completion(.failure(ServiceError.WrongData)); return}
          let benevole = Benevole(b)
          completion(.success(benevole))
        }
        else {completion(.failure(ServiceError.Failed))}
      }
      else {completion(.failure(ServiceError.Failed))}
    }
    dataTask.resume()
  }
  
  func delete(token: String, id_benevole: Int, completion: @escaping(Result<Bool, Error>) -> Void) -> Void {
    var request = URLRequest(url: URL(string: self.url+"/\(id_benevole)")!)
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
