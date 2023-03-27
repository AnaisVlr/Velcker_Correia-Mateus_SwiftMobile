//
//  AffectationService.swift
//  Velcker_Correia-Mateus_SwiftMobile
//
//  Created by m1 on 27/03/2023.
//

import Foundation

class AffectationService {
  private let url = "https://velcker-correia-mateus-api-mobile.cluster-ig3.igpolytech.fr/festival"
  
  func getAllByFestivalIdAndBenevoleId(token: String, id_festival: Int, id_benevole: Int, completion: @escaping(Result<[Affectation]?, Error>) -> Void) -> Void {
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
}
