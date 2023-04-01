//
//  Benevole.swift
//  Velcker_Correia-Mateus_SwiftMobile
//
//  Created by etud on 14/03/2023.
//

import Foundation

struct BenevoleDTO : Decodable{
  var id_benevole : Int?
  var prenom_benevole : String
  var nom_benevole : String
  var email_benevole : String
  var is_admin : Bool
  
  static func benevoleDTO2Benevole(data : [BenevoleDTO]) -> [Benevole]?{
    var benevoles = [Benevole]()
    for bdata in data{
      guard (bdata.id_benevole != nil) else{
          return nil
      }
      let benevole = Benevole(bdata)
      benevoles.append(benevole)
    }
    return benevoles
  }
    
}

class Benevole : ObservableObject, Identifiable{
  var id : Int
  var prenom : String
  var nom : String
  var email : String
  var isAdmin : Bool
  var creneau : [Creneau]
  
  init(id: Int, prenom: String, nom: String, email: String, isAdmin: Bool) {
    self.id = id
    self.prenom = prenom
    self.nom = nom
    self.email = email
    self.isAdmin = isAdmin
    self.creneau = []
  }
  
  init(_ dto: BenevoleDTO) {
    self.id = dto.id_benevole!
    self.prenom = dto.prenom_benevole
    self.nom = dto.nom_benevole
    self.email = dto.email_benevole
    self.isAdmin = dto.is_admin
    self.creneau = []
  }
  
  static func == (lhs: Benevole, rhs: Benevole) -> Bool {
    return lhs.id == rhs.id && lhs.nom == rhs.nom && lhs.prenom == rhs.prenom && lhs.email == rhs.email && lhs.isAdmin == rhs.isAdmin && lhs.creneau == rhs.creneau
  }
  
  func hash(into hasher: inout Hasher) {
    return hasher.combine(id)
  }
}

