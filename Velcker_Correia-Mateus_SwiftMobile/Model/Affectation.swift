//
//  Affectation.swift
//  Velcker_Correia-Mateus_SwiftMobile
//
//  Created by etud on 14/03/2023.
//

import Foundation

struct AffectationDTO : Decodable{
  var id_zone : Int
  var id_creneau : Int
  var id_benevole : Int
    
  static func affectationDTO2Affectation(data: [AffectationDTO]) -> [Affectation]?{
    var affectations = [Affectation]()
    for adata in data{
      let affectation = Affectation(adata)
      affectations.append(affectation)
    }
    return affectations
  }
}

class Affectation: ObservableObject, Identifiable{
  var id_zone : Int
  var id_creneau : Int
  var id_benevole : Int

  init(id_zone: Int, id_creneau: Int, id_benevole: Int) {
    self.id_zone = id_zone
    self.id_creneau = id_creneau
    self.id_benevole = id_benevole
  }
  init(_ dto: AffectationDTO) {
    self.id_zone = dto.id_zone
    self.id_creneau = dto.id_creneau
    self.id_benevole = dto.id_benevole
  }

}
