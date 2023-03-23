//
//  ZoneViewModel.swift
//  Velcker_Correia-Mateus_SwiftMobile
//
//  Created by Pain des bites on 23/03/2023.
//

import Foundation

class ZoneViewModel: ObservableObject {
  var model: Zone
  
  init(model: Zone) {
    self.model = model
  }
  
  @Published var state : ZoneState = .ready{
    didSet{
      switch state {
        case .changingName(let newname):
          print("Changement de nom")
          self.model.nom = newname
        case .changingNbBenevole(let newNumber):
          print("Changement du nombre de bénévoles nécessaires")
          self.model.nb_benevole = newNumber
        default:
          break
      }
    }
  }
  
  var nom : String {
    return model.nom
  }
  
  var nb_benevole : Int {
    return model.nb_benevole
  }
}
