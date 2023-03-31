//
//  JourIntent.swift
//  Velcker_Correia-Mateus_SwiftMobile
//
//  Created by m1 on 28/03/2023.
//

import SwiftUI

enum JourState {
    case ready
    case loading
    case error
    case updating
  
}

struct JourIntent {
  var jourVM: JourViewModel
    
  func getCreneaux(token: String) {
    jourVM.setState(.loading)
    
    CreneauService().getAllByJourId(token: token, id_jour: jourVM.id_jour) {res in
      switch res {
      case .success(let creneaux):
        jourVM.setCreneaux(creneaux!.sorted(by: { $0.debut < $1.debut}))
        jourVM.setState(.ready)
      case .failure(let error):
        print(error)
        jourVM.setState(.error)
      }
    }
  }
}

