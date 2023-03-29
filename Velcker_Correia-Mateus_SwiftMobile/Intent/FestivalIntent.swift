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
  case error
  case updating
  
}

struct FestivalIntent {
  var festivalVM: FestivalViewModel
  
}
