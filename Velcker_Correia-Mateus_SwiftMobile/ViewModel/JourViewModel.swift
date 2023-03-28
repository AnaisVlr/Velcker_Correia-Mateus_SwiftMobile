//
//  JourViewModel.swift
//  Velcker_Correia-Mateus_SwiftMobile
//
//  Created by m1 on 28/03/2023.
//

import Foundation

class JourViewModel: ObservableObject, Identifiable {
  var model: Jour
  var id=UUID()
  var observers: [JourListViewModel]
  
  init(model: Jour) {
    self.model = model
    self.observers = []
  }
  init(model: Jour, obs: JourListViewModel) {
    self.model = model
    self.observers = []
    self.register(obs)
  }
  
  @Published var state : JourState = .ready{
    didSet{
      switch state {
        case .changingName(let newname):
          if(newname != self.model.nom) {
            print("Changement de nom")
            self.model.setNom(newname)
            for o in observers { o.VMUpdated()}
          }
          
        default:
          break
      }
    }
  }
  var id_jour : Int {
    return model.id
  }
  var nom : String {
    return model.nom
  }
  var ouverture : Date {
    return model.ouverture
  }
  var fermeture : Date {
    return model.fermeture
  }
  
  public func register(_ jourLVM: JourListViewModel) {
    self.observers.append(jourLVM)
  }
}
