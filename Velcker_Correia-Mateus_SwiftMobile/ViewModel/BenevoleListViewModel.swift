//
//  BenevoleListView.swift
//  Velcker_Correia-Mateus_SwiftMobile
//
//  Created by Pain des bites on 31/03/2023.
//

import Foundation
import SwiftUI

class BenevoleListViewModel: ObservableObject {
@Published var benevoleList: [BenevoleViewModel] = []
@Published var state: BenevoleListState = .ready
  
  func setState(_ state: BenevoleListState) {
    DispatchQueue.main.async {
      self.state = state
    }
  }
  
  func setBenevoles(_ benevoles: [Benevole]) {
    DispatchQueue.main.async {
      var newList: [BenevoleViewModel] = []
      for b in benevoles {
        newList.append(BenevoleViewModel(model: b, obs: self))
      }
      self.benevoleList = newList
    }
  }
  
  func setBenevoles(_ benevoles: [BenevoleViewModel]) {
    DispatchQueue.main.async {
      self.benevoleList = benevoles
    }
  }
  
  func VMUpdated() {
    DispatchQueue.main.async {
      self.objectWillChange.send()
    }
  }
  
  func appendBenevole(_ b: Benevole) {
    DispatchQueue.main.async {
      self.benevoleList.append(BenevoleViewModel(model: b))
      self.VMUpdated()
    }
  }
  
  func appendBenevole(_ b: BenevoleViewModel) {
    DispatchQueue.main.async {
      self.benevoleList.append(b)
      self.VMUpdated()
    }
  }
}
