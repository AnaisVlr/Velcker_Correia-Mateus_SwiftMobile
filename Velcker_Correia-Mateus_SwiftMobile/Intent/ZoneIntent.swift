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
  
  func getAllBenevole(token: String) {
    zoneVM.setState(.loading)
    
    ZoneService().getAllBenevoleByZone(token:token, id_zone: zoneVM.id_zone){
      res in
      switch res{
      case .success(let benevoles):
        zoneVM.setNbBenevolePresent(self.getNbrBenevolePresent(benevoles: benevoles))
        print(zoneVM.nb_benevole_present)
        zoneVM.setState(.ready)
      case .failure(let error):
        print(error)
        zoneVM.setState(.error)
      }
    }
  }
  private func getNbrBenevolePresent(benevoles : [Benevole]?) -> Int{
    var nbr : Int = 0
    var benevolesD : [Benevole] = []
    var cpt1 : Int = 0
    var cpt2: Int = 0
    
    if benevoles != nil {
      nbr = benevoles!.count
      benevolesD = benevoles!
      print(benevolesD.count)
      if benevolesD.count != 1 {
        cpt2 = 1
        while cpt1 < benevolesD.count{
          while cpt2 < benevolesD.count{
            if benevolesD[cpt1].email == benevolesD[cpt2].email{
              nbr -= 1
              benevolesD.remove(at: cpt2)
            }else{
              cpt2 += 1
            }
            cpt1 += 1
          }
        }
      }
    }
    return nbr
  }
}
