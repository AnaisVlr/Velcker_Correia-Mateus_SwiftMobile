//
//  JeuListViewModel.swift
//  Velcker_Correia-Mateus_SwiftMobile
//
//  Created by m1 on 01/04/2023.
//

import Foundation
import SwiftUI

class JeuListViewModel: ObservableObject {
@Published var jeuList: [JeuViewModel] = []
@Published var state: JeuListState = .ready
  
  func setState(_ state: JeuListState) {
    DispatchQueue.main.async {
      self.state = state
    }
  }
  
  func setJeux(_ jeux: [Jeu]) {
    DispatchQueue.main.async {
      var newList: [JeuViewModel] = []
      for f in jeux {
        newList.append(JeuViewModel(model: f, obs: self))
      }
      self.jeuList = newList
    }
  }
  
  func setJeux(_ jeux: [JeuViewModel]) {
    DispatchQueue.main.async {
      self.jeuList = jeux
    }
  }
  
  
  func VMUpdated() {
    DispatchQueue.main.async {
      self.objectWillChange.send()
    }
  }
  
  func appendJeu(_ j: Jeu) {
    DispatchQueue.main.async {
      self.jeuList.append(JeuViewModel(model: j))
      self.VMUpdated()
    }
  }
  
  func appendJeu(_ j: JeuViewModel) {
    DispatchQueue.main.async {
      self.jeuList.append(j)
      self.VMUpdated()
    }
  }
}

