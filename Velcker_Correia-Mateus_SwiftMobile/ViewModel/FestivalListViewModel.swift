//
//  FestivalListViewModel.swift
//  Velcker_Correia-Mateus_SwiftMobile
//
//  Created by m1 on 19/03/2023.
//

import Foundation

class FestivalListViewModel: ObservableObject {
  @Published var festivals: [FestivalIntent] = []
  
  func setFestivals(_ festivals: [Festival]) {
    DispatchQueue.main.async { //Pour pouvoir modifier des variables Published dans des fonctions async
      var newList: [FestivalIntent] = []
      for f in festivals {
        newList.append(FestivalIntent(model: FestivalViewModel(model: f, obs: self)))
      }
      self.festivals = newList
    }
  }
  
  func setFestivals(_ festivals: [FestivalViewModel]) {
    DispatchQueue.main.async { //Pour pouvoir modifier des variables Published dans des fonctions async
      var newList: [FestivalIntent] = []
      for f in festivals {
        newList.append(FestivalIntent(model: f))
      }
      self.festivals = newList
    }
  }
  
  func setFestivals(_ festivals: [FestivalIntent]) {
    DispatchQueue.main.async { //Pour pouvoir modifier des variables Published dans des fonctions async
      self.festivals = festivals
    }
  }
  
  func VMUpdated() {
    DispatchQueue.main.async { //Pour pouvoir modifier des variables Published dans des fonctions async
      self.objectWillChange.send()
    }
  }
  
  func appendFestival(_ f: Festival) {
    DispatchQueue.main.async { //Pour pouvoir modifier des variables Published dans des fonctions async
      self.festivals.append(FestivalIntent(model:FestivalViewModel(model: f)))
      self.VMUpdated()
    }
  }
  
  func appendFestival(_ f: FestivalViewModel) {
    DispatchQueue.main.async { //Pour pouvoir modifier des variables Published dans des fonctions async
      self.festivals.append(FestivalIntent(model:f))
      self.VMUpdated()
    }
  }
  
  func appendFestival(_ f: FestivalIntent) {
    DispatchQueue.main.async { //Pour pouvoir modifier des variables Published dans des fonctions async
      self.festivals.append(f)
      self.VMUpdated()
    }
  }
}
