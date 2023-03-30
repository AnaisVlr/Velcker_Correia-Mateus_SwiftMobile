//
//  AffectationListViewModel.swift
//  Velcker_Correia-Mateus_SwiftMobile
//
//  Created by m1 on 29/03/2023.
//

import Foundation
import SwiftUI

class AffectationListViewModel: ObservableObject {
  @Published var state: AffectationListState = .ready
    
  @Published var creneauList: [Creneau] = []
  @Published var jourList: [Jour] = []
  @Published var zoneList: [Zone] = []
  @Published var affectationList: [Affectation] = []
  
  //Création
  @Published var jourSelected: Int = -1
  @Published var zoneSelected: Int = -1
  @Published var creneauSelected: Int = -1
  
  func setCreneau(_ creneaux: [Creneau]) {
      self.creneauList = creneaux
      print(self.affectationList.count)
  }
  
  func setZones(_ zones: [Zone]) {
      self.zoneList = zones
      print(self.affectationList.count)
  }
  
  func setJours(_ jours: [Jour]) {
      self.jourList = jours
      print(self.affectationList.count)
  }
  
  func setAffectations(_ affectations: [Affectation]) {
    DispatchQueue.main.async {
      self.affectationList = affectations
      print(self.affectationList.count)
    }
  }
  
  func appendAffectation(_ a: Affectation) {
      self.affectationList.append(a)
  }
  
  func setZoneSelected(_ z: Int) {
      self.zoneSelected = z
  }
  
  func setJourSelected(_ j: Int) {
      self.jourSelected = j
  }
  
  func setCreneauSelected(_ c: Int) {
      self.creneauSelected = c
  }
}

