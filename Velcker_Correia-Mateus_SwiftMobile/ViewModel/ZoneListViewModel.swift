//
//  ZoneListViewModel.swift
//  Velcker_Correia-Mateus_SwiftMobile
//
//  Created by Pain des bites on 23/03/2023.
//

import Foundation

class ZoneListViewModel: ObservableObject{
    @Published var zones: [Zone] = []
    
    func setZones(_ zones: [Zone]){
        DispatchQueue.main.async {
            self.zones = zones
        }
    }
}
