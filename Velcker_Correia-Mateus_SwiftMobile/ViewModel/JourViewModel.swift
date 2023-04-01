//
//  JourViewModel.swift
//  Velcker_Correia-Mateus_SwiftMobile
//
//  Created by m1 on 28/03/2023.
//

import Foundation
import SwiftUI

class JourViewModel: ObservableObject, Identifiable {
  var model: Jour
  var id=UUID()
  var observers: [JourListViewModel]
  
  @Published var state: JourState = .ready
  @Published var creneauxList: [Creneau] = []
  
  init(model: Jour) {
    self.model = model
    self.observers = []
  }
  init(model: Jour, obs: JourListViewModel) {
    self.model = model
    self.observers = []
    self.register(obs)
  }
  func setCreneaux(_ creneaux: [Creneau]) {
    DispatchQueue.main.async {
      self.creneauxList = creneaux
    }
  }
  
  func setState(_ state: JourState) {
    DispatchQueue.main.async {
      self.state = state
    }
  }
  
  func setNom(_ nom: String) {
    self.model.setNom(nom)
  }
  func setOuverture(_ date: Date) {
    self.model.setOuverture(date)
  }
  func setFermeture(_ date: Date) {
    self.model.setFermeture(date)
  }

  var id_jour : Int {
    return model.id
  }
  var nom : String {
    return model.nom
  }
  var ouverture : Date {
    return model.ouverture
  }
  var fermeture : Date {
    return model.fermeture
  }
  
  public func register(_ jourLVM: JourListViewModel) {
    self.observers.append(jourLVM)
  }
}
