//
//  ZoneListViewModel.swift
//  Velcker_Correia-Mateus_SwiftMobile
//
//  Created by Pain des bites on 23/03/2023.
//

import Foundation
import SwiftUI

class ZoneListViewModel: ObservableObject{
  @Published var zoneList: [ZoneViewModel] = []
  @Published var state: ZoneListState = .ready
  
  func setState(_ state: ZoneListState) {
    DispatchQueue.main.async {
      self.state = state
    }
  }
  
  func setZones(_ zones: [Zone]){
    DispatchQueue.main.async {
      var newList: [ZoneViewModel] = []
      for z in zones{
        newList.append(ZoneViewModel(model: z, obs: self))
      }
      self.zoneList = newList
    }
  }
  
  func setZones(_ zones: [ZoneViewModel]) {
    DispatchQueue.main.async {
      self.zoneList = zones
    }
  }
  
  func VMUpdated() {
    DispatchQueue.main.async {
      self.objectWillChange.send()
    }
  }
  
  func appendZone(_ z: Zone) {
    DispatchQueue.main.async {
      self.zoneList.append(ZoneViewModel(model: z))
      self.VMUpdated()
    }
  }
  
  func appendZone(_ z: ZoneViewModel) {
    DispatchQueue.main.async {
      self.zoneList.append(z)
      self.VMUpdated()
    }
  }
  
}
