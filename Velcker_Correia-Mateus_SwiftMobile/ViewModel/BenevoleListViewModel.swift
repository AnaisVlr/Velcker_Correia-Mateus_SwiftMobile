//
//  BenevoleListView.swift
//  Velcker_Correia-Mateus_SwiftMobile
//
//  Created by Pain des bites on 31/03/2023.
//

import Foundation
import SwiftUI

class BenevoleListViewModel: ObservableObject {
  @Published var benevoleList: [Benevole] = []
  @Published var creneauList: [Creneau] = []
  @Published var zoneList: [Zone] = []
  @Published var jourList: [Jour] = []
  @Published var state: BenevoleListState = .ready
  
  @Published var selectionCreneau: Int = 0
  
  func setState(_ state: BenevoleListState) {
    DispatchQueue.main.async {
      self.state = state
    }
  }
  
  func setCreneaux(_ creneaux: [Creneau]) {
    DispatchQueue.main.async {
      self.creneauList = creneaux
      if(creneaux.count > 0) {
        self.selectionCreneau = creneaux.first!.id_creneau
      }
    }
  }
  
  func setJours(_ jours: [Jour]) {
    DispatchQueue.main.async {
      self.jourList = jours
    }
  }
  
  func setZones(_ zones: [Zone]) {
    DispatchQueue.main.async {
      self.zoneList = zones
    }
  }
  
  func setBenevoles(_ benevoles: [Benevole]) {
    DispatchQueue.main.async {
      self.benevoleList = benevoles
    }
  }
  
  func VMUpdated() {
    DispatchQueue.main.async {
      self.objectWillChange.send()
    }
  }
  
  func appendBenevole(_ b: Benevole) {
    DispatchQueue.main.async {
      self.benevoleList.append(b)
      self.VMUpdated()
    }
  }
}
