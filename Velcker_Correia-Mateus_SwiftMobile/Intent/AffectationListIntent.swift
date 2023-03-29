//
//  AffectationListIntent.swift
//  Velcker_Correia-Mateus_SwiftMobile
//
//  Created by m1 on 29/03/2023.
//


import SwiftUI

enum AffectationListState {
  case ready
  case loading
  case creating
  case deleting
  case errorLoading
  case errorCreating
  case errorDeleting
}

struct AffectationListIntent {
  var affectationListVM: AffectationListViewModel
  
  
  
  func getAll(token: String, id_festival: Int, id_benevole: Int) {
    affectationListVM.state = .loading
    
    
    CreneauService().getAllByFestivalId(token: token, id_festival: id_festival) {res in
      switch res {
      case .success(let creneaux):
        self.affectationListVM.setCreneau(creneaux!)
        AffectationService().getAllByFestivalIdAndBenevoleId(token: token, id_festival: id_festival, id_benevole: id_benevole) {res in
          switch res {
          case .success(let affectations):
            self.affectationListVM.setAffectations(affectations!)
          case .failure(let error):
            print(error)
          }
        }
      case .failure(let error):
        print(error)
      }
    }
    JourService().getAllByFestivalId(token: token, id_festival: id_festival) {res in
      switch res {
      case .success(let jours):
        self.affectationListVM.setJours(jours!)
        if(jours != nil && !jours!.isEmpty) {
          self.affectationListVM.setJourSelected(jours!.first!.id)
          if(!self.affectationListVM.creneauList.isEmpty) {
            let idCreneau = self.affectationListVM.creneauList.first(where: {$0.id_jour == self.affectationListVM.jourSelected})
            if(idCreneau != nil) {
              self.affectationListVM.setCreneauSelected(idCreneau!.id)
            }
          }
        }
      case .failure(let error):
        print(error)
      }
    }
    

    ZoneService().getAllByFestivalId(token: token, id_festival: id_festival) {res in
      switch res {
      case .success(let zones):
        self.affectationListVM.setZones(zones!)
        if(zones != nil && !zones!.isEmpty) {
          self.affectationListVM.setZoneSelected(zones!.first!.id)
        }
        
      case .failure(let error):
        print(error)
      }
    }
    
    affectationListVM.state = .ready
  }
  
  func create(token: String, id_benevole: Int) {
    affectationListVM.state = .creating
    
    let a: Affectation = Affectation(id_zone: affectationListVM.zoneSelected, id_creneau: affectationListVM.creneauSelected, id_benevole: id_benevole)
    AffectationService().create(token: token, affectation: a) { res in
      switch res {
      case .success(let affectation):
        affectationListVM.appendAffectation(affectation)
        affectationListVM.state = .ready
      case .failure(let error):
        print(error)
        affectationListVM.state = .errorCreating
      }
    }
  }
  
  func delete(token: String, index: Int) {
    affectationListVM.state = .deleting
    affectationListVM.state = .ready
    
    /*let affectation = affectationListVM.affectationList[index]
    AffectationService().delete(token: token, affectation: affectation) {res in
      switch res {
      case .success(_ ):
        self.festivalListVM.festivalList.remove(at: index)
        self.festivalListVM.state = .ready
        
      case .failure(let error):
        print(error)
        self.festivalListVM.state = .errorDeleting
      }
    }*/
  }
}

