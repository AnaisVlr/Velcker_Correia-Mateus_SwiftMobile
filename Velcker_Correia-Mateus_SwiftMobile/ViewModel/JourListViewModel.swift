//
//  JourListViewModel.swift
//  Velcker_Correia-Mateus_SwiftMobile
//
//  Created by m1 on 28/03/2023.
//

import Foundation
import SwiftUI

class JourListViewModel: ObservableObject {
  @Published var jourList: [JourViewModel] = []
  @Published var state: JourListState = .ready
  
  func setState(_ state: JourListState) {
    DispatchQueue.main.async {
      self.state = state
    }
  }
  
  func setJours(_ jours: [Jour]) {
    DispatchQueue.main.async {
      var newList: [JourViewModel] = []
      for j in jours {
        newList.append(JourViewModel(model: j, obs: self))
      }
      self.jourList = newList
    }
  }
  
  func setJours(_ jours: [JourViewModel]) {
    DispatchQueue.main.async {
      self.jourList = jours
    }
  }
  
  
  
  func VMUpdated() {
    DispatchQueue.main.async { //Pour pouvoir modifier des variables Published dans des fonctions async
      self.objectWillChange.send()
    }
  }
  
  func appendJour(_ j: Jour) {
    DispatchQueue.main.async {
      self.jourList.append(JourViewModel(model: j))
      self.VMUpdated()
    }
  }
  
  func appendJour(_ j: JourViewModel) {
    DispatchQueue.main.async {
      self.jourList.append(j)
      self.VMUpdated()
    }
  }
  
}
