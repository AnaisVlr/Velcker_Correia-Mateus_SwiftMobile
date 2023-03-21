//
//  Festival.swift
//  Velcker_Correia-Mateus_SwiftMobile
//
//  Created by m1 on 19/03/2023.
//

import Foundation

struct FestivalDTO : Decodable{
  var id_festival : Int?
  var nom_festival : String
  var annee_festival : Int
  var nombre_jour : Int
  var is_active : Bool
    
  static func festivalDTO2Festival(data: [FestivalDTO]) -> [Festival]?{
    var festivals: [Festival] = []
    for fdata in data{
      guard (fdata.id_festival != nil) else{
          return nil
      }
      let id : Int = fdata.id_festival!
      let festival : Festival = Festival(id: id, nom: fdata.nom_festival, annee: fdata.annee_festival, nombre_jour: fdata.nombre_jour, is_active: fdata.is_active)
      festivals.append(festival)
    }
    return festivals
  }
}

class Festival: ObservableObject, Identifiable{
  var id : Int
  var nom : String
  var annee : Int
  var nombre_jour : Int
  var is_active : Bool
  
  init(id: Int, nom: String, annee: Int, nombre_jour: Int, is_active: Bool) {
    self.id = id
    self.nom = nom
    self.annee = annee
    self.nombre_jour = nombre_jour
    self.is_active = is_active
  }
}
