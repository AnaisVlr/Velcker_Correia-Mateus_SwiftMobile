//
//  JourListIntent.swift
//  Velcker_Correia-Mateus_SwiftMobile
//
//  Created by m1 on 30/03/2023.
//

import SwiftUI

enum JourListState {
  case ready
  case loading
  case deleting
  case errorLoading
  case errorDeleting
}

struct JourListIntent {
  var jourListVM: JourListViewModel
  
  func getJourListByFestivalId(token: String, id_festival: Int) {
    jourListVM.setState(.loading)
    
    JourService().getAllByFestivalId(token: token, id_festival: id_festival) {res in
      switch res {
      case .success(let jours):
        jourListVM.setJours(jours!)
        jourListVM.setState(.ready)
      case .failure(let error):
        print(error)
        jourListVM.setState(.errorLoading)
      }
    }
  }
  
  func delete(token: String, index: Int) {
    jourListVM.setState(.deleting)
    
    let jour = jourListVM.jourList[index]
    JourService().delete(token: token, id_jour: jour.id_jour) {res in
      switch res {
      case .success(_ ):
        jourListVM.jourList.remove(at: index)
        jourListVM.setState(.ready)
      case .failure(let error):
        print(error)
        jourListVM.setState(.errorDeleting)
      }
    }
  }
}

