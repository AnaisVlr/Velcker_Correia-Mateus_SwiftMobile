//
//  Jour.swift
//  Velcker_Correia-Mateus_SwiftMobile
//
//  Created by m1 on 19/03/2023.
//

import Foundation

struct JourDTO : Decodable{
  var id_jour : Int?
  var id_festival : Int
  var nom_jour : String
  var ouverture : Date
  var fermeture : Date
    
  static func jourDTO2Jour(data: [JourDTO]) -> [Jour]?{
    var jours = [Jour]()
    for jdata in data{
      guard (jdata.id_jour != nil) else{
          return nil
      }
      let jour = Jour(jdata)
      jours.append(jour)
    }
    return jours
  }
}

class Jour: ObservableObject, Hashable{
  private(set) var id : Int
  private(set) var id_festival : Int
  private(set) var nom : String
  private(set) var ouverture : Date
  private(set) var fermeture : Date
  
  func setNom(_ nom: String) {
    self.nom = nom
  }
  func setOuverture(_ ouverture: Date) {
    self.ouverture = ouverture
  }
  func setFermeture(_ fermeture: Date) {
    self.fermeture = fermeture
  }
  init(id: Int, id_festival: Int, nom: String, ouverture: Date, fermeture: Date) {
    self.id = id
    self.id_festival = id_festival
    self.nom = nom
    self.ouverture = ouverture
    self.fermeture = fermeture
  }
  init(_ dto: JourDTO) {
    self.id = dto.id_jour!
    self.id_festival = dto.id_festival
    self.nom = dto.nom_jour
    self.ouverture = dto.ouverture
    self.fermeture = dto.fermeture
  }
  static func == (lhs: Jour, rhs: Jour) -> Bool {
    return lhs.ouverture == rhs.ouverture && lhs.fermeture == rhs.fermeture
  }
  func hash(into hasher: inout Hasher) {
    return hasher.combine(id)
  }
}
