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
    
    static func jeuDTO2Jeu(data: [JeuDTO]) -> [Jeu]?{
        var jeux = [Jeu]()
        for jdata in data{
            guard (jdata.id_jeu != nil) else{
                return nil
            }
            let id : Int = jdata.id_jeu!
            let jeu = Jeu(id: id, nom: jdata.nom_jeu, type: jdata.type_jeu, zones: [Zone]())
            jeux.append(jeu)
        }
        return jeux
    }
}

class Jeu : ObservableObject{
    private var id : Int
    private(set) var nom : String
    private(set) var type : String
    private(set) var zones : [Zone]?
    
    init(id: Int, nom: String, type: String, zones: [Zone]) {
        self.id = id
        self.nom = nom
        self.type = type
        self.zones = zones
    }
}
