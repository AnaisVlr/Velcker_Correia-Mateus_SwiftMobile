//
//  ZoneListViewModel.swift
//  Velcker_Correia-Mateus_SwiftMobile
//
//  Created by Pain des bites on 23/03/2023.
//

import Foundation

class ZoneListViewModel: ObservableObject{
  @Published var zones: [ZoneIntent] = []
  
  func setZones(_ zones: [Zone]){
    DispatchQueue.main.async {
      var newList: [ZoneIntent] = []
      for z in zones{
        newList.append(ZoneIntent(model: ZoneViewModel(model: z, obs: self)))
      }
      self.zones = newList
    }
  }
  
  func setZones(_ zones: [ZoneViewModel]) {
    DispatchQueue.main.async { //Pour pouvoir modifier des variables Published dans des fonctions async
      var newList: [ZoneIntent] = []
      for z in zones {
        newList.append(ZoneIntent(model: z))
      }
      self.zones = newList
    }
  }
  
  func setZones(_ zones: [ZoneIntent]) {
    DispatchQueue.main.async { //Pour pouvoir modifier des variables Published dans des fonctions async
      self.zones = zones
    }
  }
  
  func VMUpdated() {
    DispatchQueue.main.async { //Pour pouvoir modifier des variables Published dans des fonctions async
      self.objectWillChange.send()
    }
  }
  
  func appendZone(_ z: Zone) {
    DispatchQueue.main.async { //Pour pouvoir modifier des variables Published dans des fonctions async
      self.zones.append(ZoneIntent(model:ZoneViewModel(model: z)))
      self.VMUpdated()
    }
  }
  
  func appendZone(_ z: ZoneViewModel) {
    DispatchQueue.main.async { //Pour pouvoir modifier des variables Published dans des fonctions async
      self.zones.append(ZoneIntent(model:z))
      self.VMUpdated()
    }
  }
  
  func appendZone(_ z: ZoneIntent) {
    DispatchQueue.main.async { //Pour pouvoir modifier des variables Published dans des fonctions async
      self.zones.append(z)
      self.VMUpdated()
    }
  }
}
