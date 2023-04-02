//
//  ZoneIntent.swift
//  Velcker_Correia-Mateus_SwiftMobile
//
//  Created by Pain des bites on 23/03/2023.
//

import SwiftUI

enum ZoneState {
  case ready
  case loading
  case error
  case updating
}

struct ZoneIntent {
  var zoneVM: ZoneViewModel
  
  func getNbrBenevolePresent(token: String) {
    zoneVM.setState(.loading)
    
    ZoneService().getNbBenevole(token: token, id_zone: zoneVM.id_zone){
      res in
      switch res{
      case .success(let nb):
        zoneVM.setNbBenevolePresent(nb!)
        zoneVM.setState(.ready)
      case .failure(let error):
        print(error)
        zoneVM.setState(.error)
      }
    }
  }
}
