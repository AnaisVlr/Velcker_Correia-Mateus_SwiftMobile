//
//  AffectationService.swift
//  Velcker_Correia-Mateus_SwiftMobile
//
//  Created by m1 on 27/03/2023.
//

import Foundation

class AffectationService {
  private let url = "https://velcker-correia-mateus-api-mobile.cluster-ig3.igpolytech.fr/affectation"
  
  func create(token: String, affectation: Affectation, completion: @escaping(Result<Affectation, Error>) -> Void) -> Void {
    var request = URLRequest(url: URL(string: self.url)!)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-type")
    request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
    
    let jsonString = "{ \"id_zone\": \"\(affectation.id_zone)\", \"id_benevole\": \"\(affectation.id_benevole)\", \"id_creneau\": \"\(affectation.id_creneau)\"}"
    guard let jsonData = jsonString.data(using: .utf8) else {return}
    request.httpBody = jsonData
    
    let dataTask = URLSession.shared.uploadTask(with: request,from: jsonData) { (data, response, error) in
      guard let data = data, error == nil else {
        return completion(.failure(ServiceError.NoData))
      }
      
      if let httpResponse = response as? HTTPURLResponse {
        if(httpResponse.statusCode == 201) {
          guard let a : AffectationDTO = JSONHelper.decodePasAsync(data: data) else {print("Erreur decode create Zone"); completion(.failure(ServiceError.WrongData)); return}
          let affectation = Affectation(a)
          completion(.success(affectation))
        }
        else {completion(.failure(ServiceError.Failed))}
      }
      else {completion(.failure(ServiceError.Failed))}
    }
    dataTask.resume()
  }
  
  func getAllByFestivalIdAndBenevoleId(token: String, id_festival: Int, id_benevole: Int, completion: @escaping(Result<[Affectation]?, Error>) -> Void) -> Void {
    var request = URLRequest(url: URL(string: self.url+"/festival/\(id_festival)/benevole/\(id_benevole)")!)
    request.httpMethod = "GET"
    request.setValue("application/json", forHTTPHeaderField: "Content-type")
    request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
    
    let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
      guard let data = data, error == nil else {
        return completion(.failure(ServiceError.NoData))
      }
      Task {
        do {
          let decoded : [AffectationDTO]? = await JSONHelper.decode(data: data)
          if let decoded = decoded {
            guard let affectations = AffectationDTO.affectationDTO2Affectation(data: decoded) else {
              completion(.failure(ServiceError.WrongData)); return
            }
            completion(.success(affectations))
          } else {
            completion(.failure(ServiceError.NoData))
          }
        }
      }
    }
    dataTask.resume()
  }
  
  func delete(token: String, id_benevole: Int, id_creneau: Int, id_zone: Int, completion: @escaping(Result<Bool, Error>) -> Void) -> Void {
    var request = URLRequest(url: URL(string: self.url+"/benevole/\(id_benevole)/creneau/\(id_creneau)/zone/\(id_zone)")!)
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
