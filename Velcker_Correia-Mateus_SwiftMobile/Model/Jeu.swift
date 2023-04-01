//
//  Jeu.swift
//  Velcker_Correia-Mateus_SwiftMobile
//
//  Created by etud on 14/03/2023.
//

import Foundation

struct JeuDTO : Decodable{
  var id_jeu : Int?
  var nom_jeu : String
  var type_jeu : String
  var id_festival : Int
  
  static func jeuDTO2Jeu(data: [JeuDTO]) -> [Jeu]?{
    var jeux = [Jeu]()
    for jdata in data{
      guard (jdata.id_jeu != nil) else{
        return nil
      }
      let jeu = Jeu(jdata)
      jeux.append(jeu)
    }
    return jeux
  }
}

class Jeu : ObservableObject, Identifiable{
  var id : Int
  private(set) var nom : String
  private(set) var type : String
  private(set) var id_festival : Int
  
  init(id: Int, nom: String, type: String, id_festival: Int) {
    self.id = id
    self.nom = nom
    self.type = type
    self.id_festival = id_festival
  }
  init(_ dto: JeuDTO) {
    self.id = dto.id_jeu!
    self.nom = dto.nom_jeu
    self.type = dto.type_jeu
    self.id_festival = dto.id_festival
  }
}
