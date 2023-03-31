//
//  FestivalIntent.swift
//  Velcker_Correia-Mateus_SwiftMobile
//
//  Created by m1 on 21/03/2023.
//

import SwiftUI

enum FestivalState {
  case ready
  case loading
  case errorLoading
  case updating
  case errorUpdating
}

struct FestivalIntent {
  var festivalVM: FestivalViewModel
  
  func openOrClose(token: String) {
    festivalVM.setState(.updating)
    
    FestivalService().openOrClose(token: token, festival: festivalVM.model) {res in
      switch res {
      case .success(_):
        festivalVM.setState(.ready)
        festivalVM.setIsActive(!festivalVM.is_active)
      case .failure(let error):
        print(error)
        festivalVM.setState(.errorUpdating)
      }
    }
  }
}
