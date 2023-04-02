//
//  AddBenevoleZoneViewModel.swift
//  Velcker_Correia-Mateus_SwiftMobile
//
//  Created by Pain des bites on 02/04/2023.
//

import SwiftUI

class AddBenevoleZoneViewModel: ObservableObject {
  @Published var state: AddBZState = .ready
    
  @Published var benevoleList: [Benevole] = []
  @Published var jour: Jour
  @Published var zone: Zone
  @Published var creneau: Creneau
  
  @Published var selectedBenevole : Int = -1
  
  init(benevoleList: [Benevole], jour: Jour, zone: Zone, creneau: Creneau) {
    self.benevoleList = benevoleList
    self.jour = jour
    self.zone = zone
    self.creneau = creneau
  }
  
  func setState(_ state: AddBZState) {
    DispatchQueue.main.async {
      self.state = state
    }
  }
  
  func setCreneau(_ creneau: Creneau) {
    DispatchQueue.main.async {
      self.creneau = creneau
    }
  }
  
  func setZone(_ zone: Zone) {
    DispatchQueue.main.async {
      self.zone = zone
    }
  }
  
  func setJour(_ jour: Jour) {
    DispatchQueue.main.async {
      self.jour = jour
    }
  }
  
  func setBenevoleList(_ benevoles: [Benevole]) {
    DispatchQueue.main.async {
      self.benevoleList = benevoles
    }
  }
  
  func appendBenevole(_ b: Benevole) {
    DispatchQueue.main.async {
      self.benevoleList.append(b)
    }
  }
  
  func setBenevoleSelected(_ b: Int) {
    DispatchQueue.main.async {
      self.selectedBenevole = b
    }
  }
}

