//
//  FestivalListViewModel.swift
//  Velcker_Correia-Mateus_SwiftMobile
//
//  Created by m1 on 19/03/2023.
//

import Foundation
import SwiftUI

class FestivalListViewModel: ObservableObject {
  @Published var festivalList: [FestivalViewModel] = []
  @Published var state: FestivalListState = .ready
  
  func setState(_ state: FestivalListState) {
    DispatchQueue.main.async {
      self.state = state
    }
  }
  
  func setFestivals(_ festivals: [Festival]) {
    DispatchQueue.main.async {
      var newList: [FestivalViewModel] = []
      for f in festivals {
        newList.append(FestivalViewModel(model: f, obs: self))
      }
      self.festivalList = newList
    }
  }
  
  func setFestivals(_ festivals: [FestivalViewModel]) {
    DispatchQueue.main.async {
      self.festivalList = festivals
    }
  }
  
  
  func VMUpdated() {
    DispatchQueue.main.async {
      self.objectWillChange.send()
    }
  }
  
  func appendFestival(_ f: Festival) {
    DispatchQueue.main.async {
      self.festivalList.append(FestivalViewModel(model: f))
      self.VMUpdated()
    }
  }
  
  func appendFestival(_ f: FestivalViewModel) {
    DispatchQueue.main.async {
      self.festivalList.append(f)
      self.VMUpdated()
    }
  }
}
