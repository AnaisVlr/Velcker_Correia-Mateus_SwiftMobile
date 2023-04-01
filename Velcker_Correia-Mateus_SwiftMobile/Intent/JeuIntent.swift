//
//  JeuIntent.swift
//  Velcker_Correia-Mateus_SwiftMobile
//
//  Created by m1 on 01/04/2023.
//

import SwiftUI

enum JeuState {
  case ready
  case loading
  case errorLoading
  case updating
  case errorUpdating
}

struct JeuIntent {
  var jeuVM: JeuViewModel
}

