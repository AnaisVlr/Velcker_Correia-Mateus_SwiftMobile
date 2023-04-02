//
//  AddBenevoleZoneIntent.swift
//  Velcker_Correia-Mateus_SwiftMobile
//
//  Created by Pain des bites on 02/04/2023.
//

import SwiftUI

enum AddBZState {
  case ready
  case loading
  case creating
  case errorLoading
  case errorCreating
}

struct AddBZIntent {
  var addBZVM: AddBenevoleZoneViewModel
  
  func add(token: String) {
    addBZVM.setState(.creating)
    
    let a: Affectation = Affectation(id_zone: addBZVM.zone.id, id_creneau: addBZVM.creneau.id_creneau, id_benevole: addBZVM.selectedBenevole)
    AffectationService().create(token: token, affectation: a) { res in
      switch res {
      case .success(_):
        addBZVM.setState(.ready)
      case .failure(let error):
        print(error)
        addBZVM.setState(.errorCreating)
      }
    }
  }
  
  func getBenevoleList(token: String) {
    addBZVM.setState(.loading)
    
    BenevoleService().getAll(token: token) { res in
      switch res {
      case .success(let benevoles):
        if(benevoles != nil) {
          addBZVM.setBenevoleList(benevoles!)
          addBZVM.setSelectedBenevole(benevoles!.first!.id)
        }
        addBZVM.setState(.ready)
      case .failure(let error):
        print(error)
        addBZVM.setState(.errorLoading)
      }
    }
  }
}
