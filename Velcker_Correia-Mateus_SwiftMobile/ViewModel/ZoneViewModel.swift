//
//  ZoneViewModel.swift
//  Velcker_Correia-Mateus_SwiftMobile
//
//  Created by Pain des bites on 23/03/2023.
//

import Foundation

class ZoneViewModel: ObservableObject, Identifiable {
  var model: Zone
  var id = UUID()
  var observers: [ZoneListViewModel]
  
  init(model: Zone) {
    self.model = model
    self.observers = []
  }
  
  init(model : Zone, obs: ZoneListViewModel){
    self.model = model
    self.observers = []
    self.register(obs)
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
  
  var id_zone : Int {
    return model.id
  }
  
  var nom : String {
    return model.nom
  }
  
  var nb_benevole : Int {
    return model.nb_benevole
  }
  
  public func register(_ zoneLVM : ZoneListViewModel){
    self.observers.append(zoneLVM)
  }
}
