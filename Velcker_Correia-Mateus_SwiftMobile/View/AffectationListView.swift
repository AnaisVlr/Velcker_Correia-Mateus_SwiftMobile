//
//  AffectationListView.swift
//  Velcker_Correia-Mateus_SwiftMobile
//
//  Created by m1 on 27/03/2023.
//

import SwiftUI

struct AffectationListView: View {
  @EnvironmentObject var authentification: Authentification
  @Environment(\.dismiss) private var dismiss
  
  var festival: FestivalViewModel
  @StateObject var affectationList: AffectationListViewModel = AffectationListViewModel()
  @State var intentListAffectation: AffectationListIntent = AffectationListIntent(affectationListVM: AffectationListViewModel())
  @State var erreur: String
  
  init(festival: FestivalViewModel) {
    self.festival = festival
    self._erreur = State(initialValue: "")
  }
  
  func alreadyTaken() -> Bool {
    var taken = false
    let testA = Affectation(id_zone: affectationList.zoneSelected, id_creneau: affectationList.creneauSelected, id_benevole: authentification.id)
    
    for i in affectationList.affectationList {
      if(i == testA) {
        taken = true
        break
      }
    }
    return taken
  }
  
  var body: some View {
    VStack(alignment: .center) {
      switch self.affectationList.state {
      case .loading:
        CircleLoader()
      case .deleting:
        CircleLoader()
      case .ready:
        Text("")
      case .creating:
        CircleLoader()
      case .errorCreating:
        Text("Erreur Création")
      case .errorLoading:
        Text("Erreur Chargement")
      case .errorDeleting:
        Text("Erreur Suppression")
      }
      
      if(festival.is_active) {
        VStack(alignment: .leading) {
          VStack() {
            Text("Jour :")
            Picker("Jour", selection: $affectationList.jourSelected) {
              ForEach(affectationList.jourList) {
                Text(verbatim: "\($0.nom)").tag($0.id)
              }
            }
          }
          
          VStack() {
            Text("Créneau :")
            Picker("Créneau", selection: $affectationList.creneauSelected) {
              ForEach(affectationList.creneauList, id: \.id_creneau) {
                if($0.id_jour == affectationList.jourSelected) {
                  Text(verbatim: "De \($0.debut.toString()) à \($0.fin.toString())").tag($0.id_creneau)
                }
              }
            }
          }
          
          VStack() {
            Text("Zone :")
            Picker("Zone", selection: $affectationList.zoneSelected) {
              ForEach(affectationList.zoneList, id: \.self) {
                Text(verbatim: "\($0.nom)").tag($0.id)
              }
            }
          }
        
          Text(affectationList.erreur)
          Button("S'affecter") {
            Task {
              intentListAffectation.notEnoughBenevolesInZoneCreneau(token: authentification.token, id_benevole: authentification.id)
            }
          }.disabled(affectationList.zoneSelected == -1 || affectationList.creneauSelected == -1 || affectationList.jourSelected == -1 || alreadyTaken())
        }
      }
      VStack(alignment: .leading) {
        List {
          ForEach(affectationList.affectationList) { a in
            VStack(alignment:.leading) {
              let creneau: Creneau? = affectationList.creneauList.first(where: {$0.id_creneau == a.id_creneau})
              if(creneau != nil) {
                let jour: Jour? = affectationList.jourList.first(where: {$0.id == creneau!.id_jour})
                if(jour != nil) {
                  Text("\(jour!.nom)")
                  Text("De \(creneau!.debut.toString()) à \(creneau!.fin.toString())")
                }
              }
              
              let zone: Zone? = affectationList.zoneList.first(where: {$0.id == a.id_zone})
              if(zone != nil) {
                Text("Zone : \( zone!.nom )")
              }
            }
          }.onDelete { indexSet in
            for i in indexSet { //Pour récupérer l'objet supprimé
              Task {
                self.intentListAffectation.delete(token: authentification.token, index: i)
              }
            }
          }.deleteDisabled(!festival.is_active)
        }.frame(height: 300)
      }
    }.onAppear {
      DispatchQueue.main.async {
        Task {
          intentListAffectation = AffectationListIntent(affectationListVM: affectationList)
          intentListAffectation.getAll(token: authentification.token, id_festival: festival.id_festival, id_benevole: authentification.id)
          
        }
      }
      
    }
  }
}
