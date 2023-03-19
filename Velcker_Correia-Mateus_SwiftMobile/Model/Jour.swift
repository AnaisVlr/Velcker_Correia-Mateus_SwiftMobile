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
      let id : Int = jdata.id_jour!
      let jour = Jour(id: id, id_festival: jdata.id_festival, nom: jdata.nom_jour, ouverture: jdata.ouverture, fermeture: jdata.fermeture)
      jours.append(jour)
    }
    return jours
  }
}

class Jour: ObservableObject{
  private var id : Int
  private var id_festival : Int
  private(set) var nom : String
  private(set) var ouverture : Date
  private(set) var fermeture : Date
  
  init(id: Int, id_festival: Int, nom: String, ouverture: Date, fermeture: Date) {
    self.id = id
    self.id_festival = id_festival
    self.nom = nom
    self.ouverture = ouverture
    self.fermeture = fermeture
  }
}
