//
//  Zone.swift
//  Velcker_Correia-Mateus_SwiftMobile
//
//  Created by etud on 14/03/2023.
//

import Foundation

struct ZoneDTO : Decodable{
    var id_zone : Int?
    var nom_zone : String
    
    static func zoneDTO2Zone(data: [ZoneDTO]) -> [Zone]?{
        var zones = [Zone]()
        for zdata in data{
            guard (zdata.id_zone != nil) else{
                return nil
            }
            let id : Int = zdata.id_zone!
            let zone = Zone(id: id, nom: zdata.nom_zone)
            zones.append(zone)
        }
        return zones
    }
}

class Zone: ObservableObject{
    private var id : Int
    private(set) var nom : String
    
    init(id: Int, nom: String) {
        self.id = id
        self.nom = nom
    }
}
