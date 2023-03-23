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
    
    func create(token: String, zone: Zone, completion: @escaping(Result<Bool, Error>) -> Void) -> Void {
      var request = URLRequest(url: URL(string: self.url)!)
      request.httpMethod = "POST"
      request.setValue("application/json", forHTTPHeaderField: "Content-type")
      request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
      
        let jsonString = "{ \"nom_zone\": \"\(zone.nom)\"}"
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