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
    festivalListVM.state = .loading
    
    FestivalService().getAll(token: token) {res in
      switch res {
      case .success(let festivals):
        festivalListVM.setFestivals(festivals!)
        festivalListVM.state = .ready
        
      case .failure(_ ):
        festivalListVM.state = .errorLoading
      }
    }
  }
  func delete(token: String, index: Int) {
    festivalListVM.state = .deleting
    
    let festival = festivalListVM.festivalList[index]
    FestivalService().delete(token: token, id_festival: festival.id_festival) {res in
      switch res {
      case .success(_ ):
        self.festivalListVM.festivalList.remove(at: index)
        self.festivalListVM.state = .ready
        
      case .failure(let error):
        print(error)
        self.festivalListVM.state = .errorDeleting
      }
    }
  }
}
