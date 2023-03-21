//
//  FestivalViewModel.swift
//  Velcker_Correia-Mateus_SwiftMobile
//
//  Created by m1 on 21/03/2023.
//

import Foundation

class FestivalViewModel: ObservableObject {
  var model: Festival
  
  init(model: Festival) {
    self.model = model
  }
  
  @Published var state : FestivalState = .ready{
    didSet{
      switch state {
        case .changingName(let newname):
          print("Changement de nom")
          self.model.nom = newname
        default:
          break
      }
    }
  }
  
  var nom : String {
    return model.nom
  }
}
