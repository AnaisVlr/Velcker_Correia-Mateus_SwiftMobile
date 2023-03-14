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
    var password_benevole : String
    var is_admin : Bool
    
    static func benevoleDTO2Benevole(data : [BenevoleDTO]) -> [Benevole]?{
        var benevoles = [Benevole]()
        for bdata in data{
            guard (bdata.id_benevole != nil) else{
                return nil
            }
            let id : Int = bdata.id_benevole!
            let benevole = Benevole(id: id, prenom: bdata.prenom_benevole, nom: bdata.nom_benevole, email: bdata.email_benevole, isAdmin: bdata.is_admin, creneau: [Creneau]())
            benevoles.append(benevole)
        }
        return benevoles
    }
    
}

class Benevole : ObservableObject{
    private var id : Int
    private(set) var prenom : String
    private(set) var nom : String
    private(set) var email : String
    private(set) var isAdmin : Bool
    private(set) var creneau : [Creneau]
    
    init(id: Int, prenom: String, nom: String, email: String, isAdmin: Bool, creneau: [Creneau]) {
        self.id = id
        self.prenom = prenom
        self.nom = nom
        self.email = email
        self.isAdmin = isAdmin
        self.creneau = creneau
    }
}
