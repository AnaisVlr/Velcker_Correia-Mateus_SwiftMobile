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
      let festival : Festival = Festival(dto: fdata)
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
  
  var observers: [FestivalViewModel]
  
  init(id: Int, nom: String, annee: Int, nombre_jour: Int, is_active: Bool) {
    self.id = id
    self.nom = nom
    self.annee = annee
    self.nombre_jour = nombre_jour
    self.is_active = is_active
    self.observers = []
  }
  init(dto: FestivalDTO) {
    self.id = dto.id_festival!
    self.nom = dto.nom_festival
    self.annee = dto.annee_festival
    self.nombre_jour = dto.nombre_jour
    self.is_active = dto.is_active
    self.observers = []
  }
  public func register(_ festivalVM: FestivalViewModel) {
    self.observers.append(festivalVM)
  }
  
}
