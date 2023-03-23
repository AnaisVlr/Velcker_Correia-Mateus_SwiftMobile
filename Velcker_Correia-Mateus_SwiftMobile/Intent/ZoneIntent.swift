//
//  ZoneIntent.swift
//  Velcker_Correia-Mateus_SwiftMobile
//
//  Created by Pain des bites on 23/03/2023.
//

import SwiftUI

enum ZoneState : CustomStringConvertible {
  case ready
  case changingName(String)
  case changingNbBenevole(Int)
  var description: String {
    "Etat Zone"
  }
  
}

struct ZoneIntent: Hashable, Equatable {
  @ObservedObject private var model: ZoneViewModel
  var id=UUID()
  
  init(model: ZoneViewModel) {
    self.model = model
  }
  
  func change(name: String) {
    let newname = name.trimmingCharacters(in: .whitespacesAndNewlines)
    self.model.state = .changingName(newname)
    self.model.state = .ready
  }
  
  static func == (lhs: ZoneIntent, rhs: ZoneIntent) -> Bool {
    return false
  }
  
  func hash(into hasher: inout Hasher) {
    hasher.combine(self.id)
  }
}
