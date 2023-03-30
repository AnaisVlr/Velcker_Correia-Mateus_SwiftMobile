//
//  Zone.swift
//  Velcker_Correia-Mateus_SwiftMobile
//
//  Created by etud on 14/03/2023.
//

import Foundation

struct ZoneDTO : Decodable{
  var id_zone : Int?
  var id_festival : Int
  var nom_zone : String
  var nb_benevole_necessaire : Int
    
  static func zoneDTO2Zone(data: [ZoneDTO]) -> [Zone]?{
    var zones = [Zone]()
    for zdata in data{
      guard (zdata.id_zone != nil) else{
        return nil
      }
      let zone = Zone(zdata)
      zones.append(zone)
    }
    return zones
  }
}

class Zone: ObservableObject, Identifiable, Hashable, Equatable{
  
  var id : Int
  var id_festival : Int
  var nom : String
  var nb_benevole : Int

  init(id: Int, id_festival: Int, nom: String, nb_benevole: Int) {
    self.id = id
    self.id_festival = id_festival
    self.nom = nom
    self.nb_benevole = nb_benevole
  }
  init(_ dto: ZoneDTO) {
    self.id = dto.id_zone!
    self.id_festival = dto.id_festival
    self.nom = dto.nom_zone
    self.nb_benevole = dto.nb_benevole_necessaire
  }
  
  static func == (lhs: Zone, rhs: Zone) -> Bool {
    return lhs.id == rhs.id && lhs.id_festival == rhs.id_festival && lhs.nom == rhs.nom && lhs.nb_benevole == rhs.nb_benevole
  }
  func hash(into hasher: inout Hasher) {
    return hasher.combine(id)
  }

}
