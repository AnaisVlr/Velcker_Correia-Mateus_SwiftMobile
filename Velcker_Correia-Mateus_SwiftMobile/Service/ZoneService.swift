//
//  ZoneService.swift
//  Velcker_Correia-Mateus_SwiftMobile
//
//  Created by Pain des bites on 23/03/2023.
//

import Foundation

class ZoneService {
  private let url = "https://velcker-correia-mateus-api-mobile.cluster-ig3.igpolytech.fr/zone"
    
    func getAll(token: String, completion: @escaping(Result<[Zone]?, Error>) -> Void) -> Void{
        var request = URLRequest(url: URL(string: self.url)!)
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
                    let decoded : [ZoneDTO]? = await JSONHelper.decode(data: data)
                    if let decoded = decoded {
                        guard let zones = ZoneDTO.zoneDTO2Zone(data: decoded) else {
                            completion(.failure(ServiceError.WrongData))
                            return
                        }
                        completion(.success(zones))
                    }else {
                        completion(.failure(ServiceError.NoData))
                    }
                }
            }
        }
        dataTask.resume()
    }
  
  func getAllByFestivalId(token: String, id_festival: Int, completion: @escaping(Result<[Zone]?, Error>) -> Void) -> Void{
      var request = URLRequest(url: URL(string: self.url+"/festival/\(id_festival)")!)
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
                  let decoded : [ZoneDTO]? = await JSONHelper.decode(data: data)
                  if let decoded = decoded {
                      guard let zones = ZoneDTO.zoneDTO2Zone(data: decoded) else {
                          completion(.failure(ServiceError.WrongData))
                          return
                      }
                      completion(.success(zones))
                  }else {
                      completion(.failure(ServiceError.NoData))
                  }
              }
          }
      }
      dataTask.resume()
  }
    
    func create(token: String, zone: Zone, completion: @escaping(Result<Zone, Error>) -> Void) -> Void {
      var request = URLRequest(url: URL(string: self.url)!)
      request.httpMethod = "POST"
      request.setValue("application/json", forHTTPHeaderField: "Content-type")
      request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
      
      let jsonString = "{ \"nom_zone\": \"\(zone.nom)\", \"id_festival\": \"\(zone.id_festival)\", \"nb_benevole_necessaire\": \(zone.nb_benevole)}"
      guard let jsonData = jsonString.data(using: .utf8) else {return}
      request.httpBody = jsonData
      
      let dataTask = URLSession.shared.uploadTask(with: request,from: jsonData) { (data, response, error) in
        guard let data = data, error == nil else {
          return completion(.failure(ServiceError.NoData))
        }
        if let httpResponse = response as? HTTPURLResponse {
          if(httpResponse.statusCode == 201) {
            guard let z : ZoneDTO = JSONHelper.decodePasAsync(data: data) else {print("Erreur decode create Zone"); completion(.failure(ServiceError.WrongData)); return}
            let zone = Zone(z)
            completion(.success(zone))
          }
          else {completion(.failure(ServiceError.Failed))}
        }
        else {completion(.failure(ServiceError.Failed))}
      }
      dataTask.resume()
    }
  
  func delete(token: String, id_zone: Int, completion: @escaping(Result<Bool, Error>) -> Void) -> Void {
    var request = URLRequest(url: URL(string: self.url+"/\(id_zone)")!)
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
  
  func getAllBenevoleByZone(token: String, id_zone: Int, completion: @escaping(Result<[Benevole]?, Error>) -> Void) -> Void{
    var request = URLRequest(url: URL(string: self.url+"/\(id_zone)/benevoles")!)
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
          let decoded : [BenevoleDTO]? = await JSONHelper.decode(data: data)
          if let decoded = decoded {
            guard let benevoles = BenevoleDTO.benevoleDTO2Benevole(data: decoded) else {
                completion(.failure(ServiceError.WrongData))
                return
            }
            completion(.success(benevoles))
          }else {
            completion(.failure(ServiceError.NoData))
          }
        }
      }
    }
    dataTask.resume()
  }
}
