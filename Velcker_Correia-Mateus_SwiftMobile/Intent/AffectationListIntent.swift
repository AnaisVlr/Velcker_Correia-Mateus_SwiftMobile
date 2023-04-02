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
    affectationListVM.setState(.loading)
    
    AffectationService().getAllByFestivalIdAndBenevoleId(token: token, id_festival: id_festival, id_benevole: id_benevole) {res in
      switch res {
      case .success(let affectations):
        self.affectationListVM.setAffectations(affectations!)
        
        CreneauService().getAllByFestivalId(token: token, id_festival: id_festival) {res in
          switch res {
          case .success(let creneaux):
            self.affectationListVM.setCreneau(creneaux!)
            print("Print nécessaire sinon ne fonctionne pas")
            JourService().getAllByFestivalId(token: token, id_festival: id_festival) {res in
              switch res {
              case .success(let jours):
                self.affectationListVM.setJours(jours!)
                if(jours != nil && !jours!.isEmpty) {
                  self.affectationListVM.setJourSelected(jours!.first!.id)
                  if(!creneaux!.isEmpty) {
                    print("Print nécessaire sinon ne fonctionne pas")
                    let idCreneau = creneaux!.first(where: {$0.id_jour == self.affectationListVM.jourSelected})
                    if(idCreneau != nil) {
                      print("Print nécessaire sinon ne fonctionne pas")
                      self.affectationListVM.setCreneauSelected(idCreneau!.id_creneau)
                    }
                  }
                }
                ZoneService().getAllByFestivalId(token: token, id_festival: id_festival) {res in
                  switch res {
                  case .success(let zones):
                    self.affectationListVM.setZones(zones!)
                    if(zones != nil && !zones!.isEmpty) {
                      self.affectationListVM.setZoneSelected(zones!.first!.id)
                    }
                    affectationListVM.setState(.ready)
                  case .failure(let error):
                    print(error)
                    affectationListVM.setState(.errorLoading)
                  }
                }
              case .failure(let error):
                print(error)
                affectationListVM.setState(.errorLoading)
              }
            }
          case .failure(let error):
            print(error)
            affectationListVM.setState(.errorLoading)
          }
        }
      case .failure(let error):
        print(error)
        affectationListVM.setState(.errorLoading)
      }
    }
  }
  
  func notEnoughBenevolesInZoneCreneau(token: String, id_benevole: Int) {
    affectationListVM.setState(.loading)
    affectationListVM.setErreur("")
    
    BenevoleService().getCountByZoneAndCreneau(token: token, id_zone: affectationListVM.zoneSelected, id_creneau: affectationListVM.creneauSelected) { res in
      switch res {
      case .success(let nb):
        let z = affectationListVM.zoneList.first(where: {$0.id == affectationListVM.zoneSelected})
        var bool = true
        if(z != nil) {
          if(nb! >= z!.nb_benevole) {
            affectationListVM.setErreur("Trop de bénévoles pour ce créneau")
            bool = false
          }
        }
        if(bool) {
          self.create(token: token, id_benevole: id_benevole)
        }
      case .failure(let error):
        print(error)
        affectationListVM.setState(.errorLoading)
      }
    }
  }
  
  func create(token: String, id_benevole: Int) {
    affectationListVM.setState(.creating)
    
    let a: Affectation = Affectation(id_zone: affectationListVM.zoneSelected, id_creneau: affectationListVM.creneauSelected, id_benevole: id_benevole)
    AffectationService().create(token: token, affectation: a) { res in
      switch res {
      case .success(let affectation):
        affectationListVM.appendAffectation(affectation)
        affectationListVM.setState(.ready)
      case .failure(let error):
        print(error)
        affectationListVM.setState(.errorCreating)
      }
    }
  }
  
  func delete(token: String, index: Int) {
    affectationListVM.setState(.deleting)
    
    let affectation = affectationListVM.affectationList[index]
    AffectationService().delete(token: token, id_benevole:  affectation.id_benevole, id_creneau: affectation.id_creneau, id_zone: affectation.id_zone) {res in
      switch res {
      case .success(_ ):
        affectationListVM.affectationList.remove(at: index)
        affectationListVM.setState(.ready)
        
      case .failure(let error):
        print(error)
        affectationListVM.setState(.errorDeleting)
      }
    }
  }
}

