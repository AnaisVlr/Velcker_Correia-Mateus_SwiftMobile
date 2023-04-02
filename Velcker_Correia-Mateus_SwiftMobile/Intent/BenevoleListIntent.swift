//
//  BenevoleListIntent.swift
//  Velcker_Correia-Mateus_SwiftMobile
//
//  Created by Pain des bites on 31/03/2023.
//

import SwiftUI

enum BenevoleListState {
  case ready
  case loading
  case deleting
  case errorLoading
  case errorDeleting
}

struct BenevoleListIntent {
  var benevoleListVM: BenevoleListViewModel
  
  func getBenevoleList(token: String) {
    benevoleListVM.setState(.loading)
    
    BenevoleService().getAll(token: token) {res in
      switch res {
      case .success(let benevoles):
        benevoleListVM.setBenevoles(benevoles!.sorted(by: { $0.id > $1.id}))
        benevoleListVM.setState(.ready)
        
      case .failure(_ ):
        benevoleListVM.setState(.errorLoading)
      }
    }
  }
  
  func getBenevoleByFestival(token : String, id_festival : Int) {
    benevoleListVM.setState(.loading)
    
    BenevoleService().getByFestival(token: token, id_festival: id_festival){ res in
      switch res{
      case .success(let benevoles):
        benevoleListVM.setBenevoles(benevoles!)
        benevoleListVM.setState(.ready)
        
      case .failure(_):
        benevoleListVM.setState(.errorLoading)
      }
    }
  }
  
  func getCreneauByFestival(token: String, id_festival: Int) {
    benevoleListVM.setState(.loading)
    
    CreneauService().getAllByFestivalId(token: token, id_festival: id_festival){ res in
      switch res{
      case .success(let creneaux):
        benevoleListVM.setCreneaux(creneaux!)
        benevoleListVM.setState(.ready)
        
      case .failure(_):
        benevoleListVM.setState(.errorLoading)
      }
    }
  }
  
  func getJourByFestival(token: String, id_festival: Int) {
    benevoleListVM.setState(.loading)
    
    JourService().getAllByFestivalId(token: token, id_festival: id_festival){ res in
      switch res{
      case .success(let jours):
        benevoleListVM.setJours(jours!)
        benevoleListVM.setState(.ready)
        
      case .failure(_):
        benevoleListVM.setState(.errorLoading)
      }
    }
  }
  
  func getZoneByFestival(token: String, id_festival: Int) {
    benevoleListVM.setState(.loading)
    
    ZoneService().getAllByFestivalId(token: token, id_festival: id_festival){ res in
      switch res{
      case .success(let zones):
        benevoleListVM.setZones(zones!)
        benevoleListVM.setState(.ready)
        
      case .failure(_):
        benevoleListVM.setState(.errorLoading)
      }
    }
  }
  
  func delete(token: String, index: Int) {
    benevoleListVM.setState(.deleting)
    
    let benevole = benevoleListVM.benevoleList[index]
    BenevoleService().delete(token: token, id_benevole: benevole.id) {res in
      switch res {
      case .success(_ ):
        benevoleListVM.benevoleList.remove(at: index)
        benevoleListVM.setState(.ready)
        
      case .failure(let error):
        print(error)
        benevoleListVM.setState(.errorDeleting)
      }
    }
  }
}
