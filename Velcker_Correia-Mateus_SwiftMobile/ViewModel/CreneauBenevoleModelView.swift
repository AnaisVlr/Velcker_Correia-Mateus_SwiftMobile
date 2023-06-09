//
//  CreneauBenevoleModelView.swift
//  Velcker_Correia-Mateus_SwiftMobile
//
//  Created by m1 on 02/04/2023.
//


import Foundation
import SwiftUI

class CreneauBenevoleViewModel: ObservableObject {
  @Published var benevoleList: [Benevole] = []
  
  var creneau: Creneau
  var zone: Zone
  var jour : Jour
  
  @Published var state: CreneauBenevoleState = .ready
  
  init(creneau: Creneau, zone: Zone, jour: Jour) {
    self.creneau = creneau
    self.zone = zone
    self.jour = jour
  }
  
  func setState(_ state: CreneauBenevoleState) {
    DispatchQueue.main.async {
      self.state = state
    }
  }
  
  func setBenevoles(_ benevoles: [Benevole]) {
    DispatchQueue.main.async {
      self.benevoleList = benevoles
    }
  }
}
