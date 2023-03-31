//
//  ZoneListIntent.swift
//  Velcker_Correia-Mateus_SwiftMobile
//
//  Created by m1 on 30/03/2023.
//

import SwiftUI

enum ZoneListState {
  case ready
  case loading
  case deleting
  case errorLoading
  case errorDeleting
}

struct ZoneListIntent {
  var zoneListVM: ZoneListViewModel
  
  func getZoneList(token: String, id_festival: Int) {
    zoneListVM.setState(.loading)
    
    ZoneService().getAllByFestivalId(token: token, id_festival: id_festival) {res in
      switch res {
      case .success(let zones):
        zoneListVM.setZones(zones!)
        zoneListVM.setState(.ready)
      case .failure(let error):
        print(error)
        zoneListVM.setState(.errorLoading)
      }
    }
  }
  func delete(token: String, index: Int) {
    zoneListVM.setState(.deleting)
    
    let zone = zoneListVM.zoneList[index]
    ZoneService().delete(token: token, id_zone: zone.id_zone) {res in
      switch res {
      case .success(_ ):
        zoneListVM.zoneList.remove(at: index)
        zoneListVM.setState(.ready)
        
      case .failure(let error):
        print(error)
        zoneListVM.setState(.errorDeleting)
      }
    }
  }
}

