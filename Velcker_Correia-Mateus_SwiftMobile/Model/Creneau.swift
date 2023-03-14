//
//  Creneau.swift
//  Velcker_Correia-Mateus_SwiftMobile
//
//  Created by etud on 14/03/2023.
//

import Foundation

class Creneau : ObservableObject{
    private(set) var benevole : Benevole
    private(set) var zone : Zone
    private(set) var debut : Date
    private(set) var fin : Date
    
    init(benevole: Benevole, zone: Zone, debut: Date, fin: Date) {
        self.benevole = benevole
        self.zone = zone
        self.debut = debut
        self.fin = fin
    }
}
