//
//  FestivalViewModel.swift
//  Velcker_Correia-Mateus_SwiftMobile
//
//  Created by m1 on 21/03/2023.
//

import Foundation

class FestivalViewModel: ObservableObject, Identifiable {
  var model: Festival
  var id=UUID()
  var observers: [FestivalListViewModel]
  
  init(model: Festival) {
    self.model = model
    self.observers = []
  }
  init(model: Festival, obs: FestivalListViewModel) {
    self.model = model
    self.observers = []
    self.register(obs)
  }
  
  @Published var state : FestivalState = .ready{
    didSet{
      switch state {
        case .changingName(let newname):
          if(newname != self.model.nom) {
            print("Changement de nom")
            self.model.nom = newname
            for o in observers { o.VMUpdated()}
          }
          
        default:
          break
      }
    }
  }
  var id_festival : Int {
    return model.id
  }
  var nom : String {
    return model.nom
  }
  var annee : Int {
    return model.annee
  }
  var nombre_jour : Int {
    return model.nombre_jour
  }
  var is_active : Bool {
    return model.is_active
  }
  
  public func register(_ festivalLVM: FestivalListViewModel) {
    self.observers.append(festivalLVM)
  }
}
