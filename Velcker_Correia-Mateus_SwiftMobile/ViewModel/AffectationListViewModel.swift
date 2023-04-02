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
  @Published var erreur: String = ""
  
  func setState(_ state: AffectationListState) {
    DispatchQueue.main.async {
      self.state = state
    }
  }
  
  func setErreur(_ erreur: String) {
    DispatchQueue.main.async {
      self.erreur = erreur
    }
  }
  
  func setCreneau(_ creneaux: [Creneau]) {
    DispatchQueue.main.async {
      self.creneauList = creneaux
    }
  }
  
  func setZones(_ zones: [Zone]) {
    DispatchQueue.main.async {
      self.zoneList = zones
    }
  }
  
  func setJours(_ jours: [Jour]) {
    DispatchQueue.main.async {
      self.jourList = jours
    }
  }
  
  func setAffectations(_ affectations: [Affectation]) {
    DispatchQueue.main.async {
      self.affectationList = affectations
    }
  }
  
  func appendAffectation(_ a: Affectation) {
    DispatchQueue.main.async {
      self.affectationList.append(a)
    }
  }
  
  func setZoneSelected(_ z: Int) {
    DispatchQueue.main.async {
      self.zoneSelected = z
    }
  }
  
  func setJourSelected(_ j: Int) {
    DispatchQueue.main.async {
      self.jourSelected = j
    }
  }
  
  func setCreneauSelected(_ c: Int) {
    DispatchQueue.main.async {
      self.creneauSelected = c
    }
  }
}

