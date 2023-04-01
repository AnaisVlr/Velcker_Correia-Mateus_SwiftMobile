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
}
