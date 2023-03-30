//
//  FestivalListIntent.swift
//  Velcker_Correia-Mateus_SwiftMobile
//
//  Created by m1 on 29/03/2023.
//

import SwiftUI

enum FestivalListState {
  case ready
  case loading
  case deleting
  case errorLoading
  case errorDeleting
}

struct FestivalListIntent {
  var festivalListVM: FestivalListViewModel
  
  func getFestivalList(token: String) {
    festivalListVM.setState(.loading)
    
    FestivalService().getAll(token: token) {res in
      switch res {
      case .success(let festivals):
        festivalListVM.setFestivals(festivals!)
        festivalListVM.setState(.ready)
        
      case .failure(_ ):
        festivalListVM.setState(.errorLoading)
      }
    }
  }
  func delete(token: String, index: Int) {
    festivalListVM.setState(.deleting)
    
    let festival = festivalListVM.festivalList[index]
    FestivalService().delete(token: token, id_festival: festival.id_festival) {res in
      switch res {
      case .success(_ ):
        festivalListVM.festivalList.remove(at: index)
        festivalListVM.setState(.ready)
        
      case .failure(let error):
        print(error)
        festivalListVM.setState(.errorDeleting)
      }
    }
  }
}
