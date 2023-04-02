//
//  CreneauBenevoleList.swift
//  Velcker_Correia-Mateus_SwiftMobile
//
//  Created by m1 on 02/04/2023.
//

import SwiftUI

enum CreneauBenevoleState {
  case ready
  case loading
  case errorLoading
}

struct CreneauBenevoleIntent {
  var creneauBenevoleVM: CreneauBenevoleViewModel
  
  func getBenevoleList(token: String) {
    creneauBenevoleVM.setState(.loading)
    
    BenevoleService().getByZoneAndCreneau(token: token, id_zone: creneauBenevoleVM.zone.id, id_creneau: creneauBenevoleVM.creneau.id_creneau) {res in
      switch res {
      case .success(let benevoles):
        creneauBenevoleVM.setBenevoles(benevoles!.sorted(by: { $0.id > $1.id}))
        creneauBenevoleVM.setState(.ready)
        
      case .failure(_ ):
        creneauBenevoleVM.setState(.errorLoading)
      }
    }
  }
}

