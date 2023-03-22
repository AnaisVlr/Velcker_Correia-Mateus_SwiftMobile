//
//  FestivalService.swift
//  Velcker_Correia-Mateus_SwiftMobile
//
//  Created by m1 on 20/03/2023.
//

import Foundation

class FestivalService {
  private let url = "https://velcker-correia-mateus-api-mobile.cluster-ig3.igpolytech.fr/festival"
  
  func getAll(token: String, completion: @escaping(Result<[Festival]?, Error>) -> Void) -> Void {
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
          let decoded : [FestivalDTO]? = await JSONHelper.decode(data: data)
          if let decoded = decoded {
            guard let festivals = FestivalDTO.festivalDTO2Festival(data: decoded) else {
              completion(.failure(ServiceError.WrongData)); return
            }
            
            completion(.success(festivals))
          } else {
            completion(.failure(ServiceError.NoData))
          }
        }
      }
    }
    dataTask.resume()
  }
  
  func create(token: String, festival: Festival, completion: @escaping(Result<Bool, Error>) -> Void) -> Void {
    var request = URLRequest(url: URL(string: self.url)!)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-type")
    request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
    
    let jsonString = "{ \"nom_festival\": \"\(festival.nom)\", \"annee_festival\": \(festival.annee), \"nombre_jour\": \(festival.nombre_jour), \"is_active\": \(festival.is_active) }"
    guard let jsonData = jsonString.data(using: .utf8) else {return}
    request.httpBody = jsonData
    
    let dataTask = URLSession.shared.uploadTask(with: request,from: jsonData) { (data, response, error) in
      guard let data = data, error == nil else {
        return completion(.failure(ServiceError.NoData))
      }
      if let httpResponse = response as? HTTPURLResponse {
        if(httpResponse.statusCode == 201) {
          completion(.success(true))
        }
        else {completion(.failure(ServiceError.Failed))}
      }
      else {completion(.failure(ServiceError.Failed))}
    }
    dataTask.resume()
  }
}
