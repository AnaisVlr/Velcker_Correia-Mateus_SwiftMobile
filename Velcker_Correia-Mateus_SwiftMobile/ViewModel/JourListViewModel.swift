//
//  JourListViewModel.swift
//  Velcker_Correia-Mateus_SwiftMobile
//
//  Created by m1 on 28/03/2023.
//

import Foundation

class JourListViewModel: ObservableObject {
  @Published var jours: [JourIntent] = []
  
  func setJours(_ jours: [Jour]) {
    DispatchQueue.main.async { //Pour pouvoir modifier des variables Published dans des fonctions async
      var newList: [JourIntent] = []
      for j in jours {
        newList.append(JourIntent(model: JourViewModel(model: j, obs: self)))
      }
      self.jours = newList
    }
  }
  
  func setJours(_ jours: [JourViewModel]) {
    DispatchQueue.main.async { //Pour pouvoir modifier des variables Published dans des fonctions async
      var newList: [JourIntent] = []
      for j in jours {
        newList.append(JourIntent(model: j))
      }
      self.jours = newList
    }
  }
  
  func setjours(_ jours: [JourIntent]) {
    DispatchQueue.main.async { //Pour pouvoir modifier des variables Published dans des fonctions async
      self.jours = jours
    }
  }
  
  func VMUpdated() {
    DispatchQueue.main.async { //Pour pouvoir modifier des variables Published dans des fonctions async
      self.objectWillChange.send()
    }
  }
  
  func appendJour(_ j: Jour) {
    DispatchQueue.main.async { //Pour pouvoir modifier des variables Published dans des fonctions async
      self.jours.append(JourIntent(model:JourViewModel(model: j)))
      self.VMUpdated()
    }
  }
  
  func appendJour(_ j: JourViewModel) {
    DispatchQueue.main.async { //Pour pouvoir modifier des variables Published dans des fonctions async
      self.jours.append(JourIntent(model:j))
      self.VMUpdated()
    }
  }
  
  func appendJour(_ j: JourIntent) {
    DispatchQueue.main.async { //Pour pouvoir modifier des variables Published dans des fonctions async
      self.jours.append(j)
      self.VMUpdated()
    }
  }
}
