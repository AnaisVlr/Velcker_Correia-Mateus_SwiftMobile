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
  @State var state: FestivalListState = .ready
  
  func setFestivals(_ festivals: [Festival]) {
    DispatchQueue.main.async { //Pour pouvoir modifier des variables Published dans des fonctions async
      var newList: [FestivalViewModel] = []
      for f in festivals {
        newList.append(FestivalViewModel(model: f, obs: self))
      }
      self.festivalList = newList
    }
  }
  
  func setFestivals(_ festivals: [FestivalViewModel]) {
    DispatchQueue.main.async { //Pour pouvoir modifier des variables Published dans des fonctions async
      self.festivalList = festivals
    }
  }
  
  
  func VMUpdated() {
    DispatchQueue.main.async { //Pour pouvoir modifier des variables Published dans des fonctions async
      self.objectWillChange.send()
    }
  }
  
  func appendFestival(_ f: Festival) {
    DispatchQueue.main.async { //Pour pouvoir modifier des variables Published dans des fonctions async
      self.festivalList.append(FestivalViewModel(model: f))
      self.VMUpdated()
    }
  }
  
  func appendFestival(_ f: FestivalViewModel) {
    DispatchQueue.main.async { //Pour pouvoir modifier des variables Published dans des fonctions async
      self.festivalList.append(f)
      self.VMUpdated()
    }
  }
}
