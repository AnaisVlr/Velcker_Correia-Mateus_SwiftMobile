//
//  FestivalListViewModel.swift
//  Velcker_Correia-Mateus_SwiftMobile
//
//  Created by m1 on 19/03/2023.
//

import Foundation

class FestivalListViewModel: ObservableObject {
  @Published var festivals: [Festival] = []
  
  func setFestivals(_ festivals: [Festival]) {
    DispatchQueue.main.async { //Pour pouvoir modifier des variables Published
      self.festivals = festivals
    }
  }
}
