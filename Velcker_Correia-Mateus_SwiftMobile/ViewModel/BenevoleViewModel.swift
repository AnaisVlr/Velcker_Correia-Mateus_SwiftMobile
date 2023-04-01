//
//  BenevoleViewModel.swift
//  Velcker_Correia-Mateus_SwiftMobile
//
//  Created by Pain des bites on 31/03/2023.
//

import Foundation
import SwiftUI

class BenevoleViewModel: ObservableObject, Identifiable {
  var model: Benevole
  var id=UUID()
  var observers: [BenevoleListViewModel]
  @Published var state: BenevoleState = .ready
  
  init(model: Benevole) {
    self.model = model
    self.observers = []
  }
  
  init(model: Benevole, obs: BenevoleListViewModel) {
    self.model = model
    self.observers = []
    self.register(obs)
  }
  
  func setState(_ state: BenevoleState) {
    DispatchQueue.main.async {
      self.state = state
    }
  }
  
  func setBenevole(_ benevole: Benevole) {
    DispatchQueue.main.async {
      self.model = benevole
    }
  }
  
  func VMUpdated() {
    DispatchQueue.main.async {
      self.objectWillChange.send()
    }
  }

  var id_benevole : Int {
    return model.id
  }
  
  var prenom : String {
    return model.prenom
  }
  
  var nom : String {
    return model.nom
  }
  
  var email : String{
    return model.email
  }
  
  var isAdmin : Bool{
    return model.isAdmin
  }
  
  var creneaux : [Creneau]{
    return model.creneau
  }
  
  public func register(_ benevoleLVM: BenevoleListViewModel) {
    self.observers.append(benevoleLVM)
  }
}
