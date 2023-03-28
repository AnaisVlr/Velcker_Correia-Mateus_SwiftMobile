//
//  JourIntent.swift
//  Velcker_Correia-Mateus_SwiftMobile
//
//  Created by m1 on 28/03/2023.
//

import SwiftUI


enum JourState : CustomStringConvertible {
  case ready
  case changingName(String)
  case changingCreneau([Creneau])
  var description: String {
    "Etat jour"
  }
  
}

struct JourIntent: Hashable, Equatable, Identifiable {
  @ObservedObject private var model: JourViewModel
  var id=UUID()
  
  init(model: JourViewModel) {
    self.model = model
  }
  
  func getId() -> Int {
    return model.id_jour
  }
  
  func getNom() -> String {
    return model.nom
  }
  
  func getOuverture() -> Date {
    return model.ouverture
  }
  
  func getFermeture() -> Date {
    return model.fermeture
  }
  
  func change(name: String) {
    let newname = name.trimmingCharacters(in: .whitespacesAndNewlines)
    self.model.state = .changingName(newname)
    self.model.state = .ready
  }
  
  
  static func == (lhs: JourIntent, rhs: JourIntent) -> Bool {
    return lhs.id == rhs.id
  }
  
  func hash(into hasher: inout Hasher) {
    hasher.combine(self.id)
  }
}

