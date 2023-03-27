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
  var festival: FestivalIntent
  @State var creneauList: [Creneau] = []
  @State var jourList: [Jour] = []
  @State var zoneList: [Zone] = []
  @State var affectationList: [Affectation] = []
  
  //Création
  @State var jourSelected: Int = -1
  @State var zoneSelected: Int = -1
  @State var creneauSelected: Int = -1
  
  func delete(at offsets: IndexSet) {
    affectationList.remove(atOffsets: offsets)
  }
  
  var body: some View {
    VStack(alignment: .center) {
      VStack(alignment: .leading) {
        VStack() {
          Text("Jour :")
          Picker("Jour", selection: $jourSelected) {
            ForEach(jourList, id: \.self) {
              Text(verbatim: "\($0.nom)").tag($0.id)
            }
          }
        }
        VStack() {
          Text("Créneau :")
          Picker("Créneau", selection: $creneauSelected) {
            ForEach(creneauList, id: \.self) {
              if($0.id_jour == jourSelected) {
                Text(verbatim: "De \($0.debutString()) à \($0.finString())").tag($0.id)
              }
              
            }
          }
        }
        VStack() {
          Text("Zone :")
          Picker("Zone", selection: $zoneSelected) {
            ForEach(zoneList, id: \.self) {
              Text(verbatim: "\($0.nom)").tag($0.id)
            }
          }
        }
        
        Button("S'affecter") {
          let a: Affectation = Affectation(id_zone: zoneSelected, id_creneau: creneauSelected, id_benevole: authentification.id)
          AffectationService().create(token: authentification.token, affectation: a) { res in
            switch res {
            case .success(let affectation):
              print(affectation)
            case .failure(let error):
              print(error)
            }
          }
        }
      }
      VStack(alignment: .leading) {
        List {
          ForEach(affectationList) { a in
            VStack(alignment:.leading) {
              let creneau: Creneau? = creneauList.first(where: {$0.id == a.id_creneau})
              if(creneau != nil) {
                let jour: Jour? = jourList.first(where: {$0.id == creneau!.id_jour})
                if(jour != nil) {
                  Text("\(jour!.nom)")
                  Text("De \(creneau!.debutString()) à \(creneau!.finString())")
                }
              }
              
              let zone: Zone? = zoneList.first(where: {$0.id == a.id_zone})
              if(zone != nil) {
                Text("Zone : \( zone!.nom )")
              }
              
            }
          }.onDelete { indexSet in
            self.delete(at: indexSet)
        }
      }
    }.onAppear {
        Task {
          AffectationService().getAllByFestivalIdAndBenevoleId(token: authentification.token, id_festival: festival.getId(), id_benevole: authentification.id) {res in
            switch res {
            case .success(let affectations):
              self.affectationList = affectations!
              
            case .failure(let error):
              print(error)
            }
          }
        }
        Task {
          CreneauService().getAllByFestivalId(token: authentification.token, id_festival: festival.getId()) {res in
            switch res {
            case .success(let creneaux):
              self.creneauList = creneaux!
            case .failure(let error):
              print(error)
            }
          }
        }
        Task {
          JourService().getAllByFestivalId(token: authentification.token, id_festival: festival.getId()) {res in
            switch res {
            case .success(let jours):
              self.jourList = jours!
              if(jours != nil && !jours!.isEmpty) {
                self.jourSelected = jours!.first!.id
                if(!self.creneauList.isEmpty) {
                  let idCreneau = self.creneauList.first(where: {$0.id_jour == self.jourSelected})
                  if(idCreneau != nil) {
                    self.creneauSelected = idCreneau!.id
                  }
                }
              }
            case .failure(let error):
              print(error)
            }
          }
        }
        Task {
          ZoneService().getAllByFestivalId(token: authentification.token, id_festival: festival.getId()) {res in
            switch res {
            case .success(let zones):
              self.zoneList = zones!
              if(zones != nil && !zones!.isEmpty) {
                self.zoneSelected = self.zoneList.first!.id
              }
              
            case .failure(let error):
              print(error)
            }
          }
        }
      }
    }
  }
}
