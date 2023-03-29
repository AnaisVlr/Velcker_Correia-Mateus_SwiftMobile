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
  
  func create(token: String, festival: Festival, completion: @escaping(Result<Festival, Error>) -> Void) -> Void {
    var request = URLRequest(url: URL(string: self.url)!)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-type")
    request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
    
    let jsonString = "{ \"nom_festival\": \"\(festival.nom)\", \"annee_festival\": \(festival.annee), \"nombre_jour\": 0, \"is_active\": \(festival.is_active) }"
    guard let jsonData = jsonString.data(using: .utf8) else {return}
    request.httpBody = jsonData
    
    let dataTask = URLSession.shared.uploadTask(with: request,from: jsonData) { (data, response, error) in
      guard let data = data, error == nil else {
        return completion(.failure(ServiceError.NoData))
      }
      if let httpResponse = response as? HTTPURLResponse {
        if(httpResponse.statusCode == 201) {
          guard let f : FestivalDTO = JSONHelper.decodePasAsync(data: data) else {print("Erreur decode create Festival"); completion(.failure(ServiceError.WrongData)); return}
          let festivalRes = Festival(dto: f)
          //Création de la zone "Libre"
          let zone = Zone(id: -1, id_festival: festivalRes.id, nom: "Libre", nb_benevole: 1)
          ZoneService().create(token: token, zone: zone) { success in}
          //Création des jours
          let userCalendar = Calendar(identifier: .iso8601)
          for i in 1...festival.nombre_jour {
            var dateC = DateComponents()
            dateC.hour = 8
            dateC.minute = 0
            dateC.second = 0
            let ouverture = userCalendar.date(from: dateC)!
            print(dateC)
            print(ouverture)
            dateC.hour = 18
            let fermeture = userCalendar.date(from: dateC)!
            let jour: Jour = Jour(id: -1, id_festival: festivalRes.id, nom: "Jour\(i)", ouverture: ouverture, fermeture: fermeture)
            //Création des créneaux
            JourService().create(token: token, jour: jour) { res in}
          }
          
          
          completion(.success(festivalRes))
        }
        else {completion(.failure(ServiceError.Failed))}
      }
      else {completion(.failure(ServiceError.Failed))}
    }
    dataTask.resume()
  }
  
  func delete(token: String, id_festival: Int, completion: @escaping(Result<Bool, Error>) -> Void) -> Void {
    var request = URLRequest(url: URL(string: self.url+"/\(id_festival)")!)
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
