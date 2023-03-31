//
//  ZoneViewModel.swift
//  Velcker_Correia-Mateus_SwiftMobile
//
//  Created by Pain des bites on 23/03/2023.
//

import Foundation
import SwiftUI

class ZoneViewModel: ObservableObject, Identifiable {
  var model: Zone
  var id = UUID()
  var observers: [ZoneListViewModel]
  @Published var state: ZoneState = .ready
  
  @Published var nb_benevole_present = 0
  
  init(model: Zone) {
    self.model = model
    self.observers = []
  }
  
  init(model : Zone, obs: ZoneListViewModel){
    self.model = model
    self.observers = []
    self.register(obs)
  }
  
  func setState(_ state: ZoneState) {
    DispatchQueue.main.async {
      self.state = state
    }
  }
  
  func setNbBenevolePresent(_ nb: Int) {
    DispatchQueue.main.async {
      self.nb_benevole_present = nb
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
