//
//  Creneau.swift
//  Velcker_Correia-Mateus_SwiftMobile
//
//  Created by etud on 14/03/2023.
//

import Foundation

struct CreneauDTO : Decodable{
  var id_creneau : Int?
  var id_jour : Int
  var debut : Date
  var fin : Date
    
  static func creneauDTO2Creneau(data: [CreneauDTO]) -> [Creneau]?{
    var creneaux = [Creneau]()
    for cdata in data{
      guard (cdata.id_creneau != nil) else{
        return nil
      }
      let creneau = Creneau(cdata)
      creneaux.append(creneau)
    }
    return creneaux
  }
}

class Creneau : ObservableObject{
  private(set) var id : Int
  private(set) var id_jour : Int
  private(set) var debut : Date
  private(set) var fin : Date
    
  init(id: Int, id_jour: Int, debut: Date, fin: Date) {
    self.id = id
    self.id_jour = id_jour
    self.debut = debut
    self.fin = fin
  }
  init(_ dto: CreneauDTO) {
    self.id = dto.id_creneau!
    self.id_jour = dto.id_jour
    self.debut = dto.debut
    self.fin = dto.fin
  }
}
