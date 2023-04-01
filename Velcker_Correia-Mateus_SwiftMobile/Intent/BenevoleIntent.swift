//
//  BenevoleIntent.swift
//  Velcker_Correia-Mateus_SwiftMobile
//
//  Created by Pain des bites on 31/03/2023.
//

import Foundation

import SwiftUI

enum BenevoleState {
  case ready
  case loading
  case errorLoading
  case updating
  case errorUpdating
}

struct BenevoleIntent {
  var benevoleVM: BenevoleViewModel
  
  func getBenevoleByEmail(token: String, email : String) {
    benevoleVM.setState(.loading)
    
    BenevoleService().getByEmail(token: token, email: email) {res in
      switch res {
      case .success(let benevole):
        benevoleVM.setBenevole(benevole!)
        benevoleVM.setState(.ready)
        
      case .failure(_ ):
        benevoleVM.setState(.errorLoading)
      }
    }
  }
}
