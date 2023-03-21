//
//  FestivalIntent.swift
//  Velcker_Correia-Mateus_SwiftMobile
//
//  Created by m1 on 21/03/2023.
//

import SwiftUI

enum FestivalState : CustomStringConvertible {
  case ready
  case changingName(String)
  case changingZones([Zone])
  var description: String {
    "Etat festival"
  }
  
}

struct FestivalIntent: Hashable, Equatable {
  @ObservedObject private var model: FestivalViewModel
  var id=UUID()
  
  init(model: FestivalViewModel) {
    self.model = model
  }
  
  func change(name: String) {
    let newname = name.trimmingCharacters(in: .whitespacesAndNewlines)
    self.model.state = .changingName(newname)
    self.model.state = .ready
  }
  static func == (lhs: FestivalIntent, rhs: FestivalIntent) -> Bool {
    return false
  }
  func hash(into hasher: inout Hasher) {
    hasher.combine(self.id)
  }
}
