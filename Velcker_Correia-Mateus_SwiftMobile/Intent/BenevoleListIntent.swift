//
//  BenevoleListIntent.swift
//  Velcker_Correia-Mateus_SwiftMobile
//
//  Created by Pain des bites on 31/03/2023.
//

import SwiftUI

enum BenevoleListState {
  case ready
  case loading
  case deleting
  case errorLoading
  case errorDeleting
}

struct BenevoleListIntent {
  var benevoleListVM: BenevoleListViewModel
  
  func getBenevoleList(token: String) {
    benevoleListVM.setState(.loading)
    
    BenevoleService().getAll(token: token) {res in
      switch res {
      case .success(let benevoles):
        benevoleListVM.setBenevoles(benevoles!.sorted(by: { $0.id > $1.id}))
        benevoleListVM.setState(.ready)
        
      case .failure(_ ):
        benevoleListVM.setState(.errorLoading)
      }
    }
  }
}
