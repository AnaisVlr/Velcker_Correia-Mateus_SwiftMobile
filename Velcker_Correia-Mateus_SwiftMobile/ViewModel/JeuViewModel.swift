//
//  JeuViewModel.swift
//  Velcker_Correia-Mateus_SwiftMobile
//
//  Created by m1 on 01/04/2023.
//

import Foundation
import SwiftUI

class JeuViewModel: ObservableObject, Identifiable {
  var model: Jeu
  var id=UUID()
  var observers: [JeuListViewModel]
  @Published var state: JeuState = .ready
  
  init(model: Jeu) {
    self.model = model
    self.observers = []
  }
  init(model: Jeu, obs: JeuListViewModel) {
    self.model = model
    self.observers = []
    self.register(obs)
  }
  
  func setState(_ state: JeuState) {
    DispatchQueue.main.async {
      self.state = state
    }
  }

  var id_jeu : Int {
    return model.id
  }
  var nom : String {
    return model.nom
  }
  var type : String {
    return model.type
  }
  var id_festival : Int {
    return model.id_festival
  }
  
  public func register(_ jeuLVM: JeuListViewModel) {
    self.observers.append(jeuLVM)
  }
}

