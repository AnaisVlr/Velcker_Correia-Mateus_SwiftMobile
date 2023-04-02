//
//  BenevoleListView.swift
//  Velcker_Correia-Mateus_SwiftMobile
//
//  Created by Pain des bites on 31/03/2023.
//

import SwiftUI

struct BenevoleListView: View {
  @EnvironmentObject var authentification: Authentification
  
  @ObservedObject var benevoleListVM: BenevoleListViewModel
  var intentBenevoleList: BenevoleListIntent
  
  @State var festival : FestivalViewModel
  
  @State var searchByCreneau: Bool = false
  
  init(festival : FestivalViewModel){
    self._festival = State(initialValue: festival)
    
    let bL = BenevoleListViewModel()
    self.benevoleListVM = bL
    self.intentBenevoleList = BenevoleListIntent(benevoleListVM: bL)
  }

  var body: some View {
    if(festival.is_active) {
      VStack(alignment: .leading) {
        HStack(alignment: .center) {
          Text("\(benevoleListVM.benevoleList.count) bénévole(s) présent(s) au festival :")
        }.padding()
        HStack() {
          if(searchByCreneau) {
            Button("Voir les bénévoles") {
              searchByCreneau = false
            }.buttonStyle(CustomButton())
            Picker("Créneaux", selection: $benevoleListVM.selectionCreneau) {
              ForEach(benevoleListVM.creneauList) { c in
                let j = benevoleListVM.jourList.first(where: {$0.id == c.id_jour})
                if(j != nil) {
                  Text("\(j!.nom) : \(c.debut.toString()) - \(c.fin.toString())").tag(c.id_creneau)
                }
                else {
                  Text("\(c.debut.toString()) - \(c.fin.toString())").tag(c.id_creneau)
                }
              }
            }
          }
          else {
            Button("Chercher par créneau") {
              searchByCreneau = true
            }.buttonStyle(CustomButton())
          }
          
          
        }
        
        List {
          if(!searchByCreneau) {
            ForEach(benevoleListVM.benevoleList) { b in
              VStack(alignment:.leading) {
                Text(b.prenom + " " + b.nom).bold()
                Text(b.email)
              }
            }
          }
          else {
            ForEach(benevoleListVM.zoneList) {z in
              let c = benevoleListVM.creneauList.first(where: {$0.id_creneau == benevoleListVM.selectionCreneau})
              if( c != nil) {
                let j = benevoleListVM.jourList.first(where: {$0.id == c!.id_jour})
                if(j != nil) {
                  CreneauBenevoleView(creneau: c!, zone: z, jour: j!, benevoleList: benevoleListVM.benevoleList)
                }
              }
            }
          }
          
        }.frame(height: 500)
      }.onAppear(){
        Task {
          intentBenevoleList.getBenevoleByFestival(token:authentification.token, id_festival: festival.id_festival)
        }
        Task {
          intentBenevoleList.getCreneauByFestival(token: authentification.token, id_festival: festival.id_festival)
        }
        Task {
          intentBenevoleList.getZoneByFestival(token: authentification.token, id_festival: festival.id_festival)
        }
        Task {
          intentBenevoleList.getJourByFestival(token: authentification.token, id_festival: festival.id_festival)
        }
      }
    }
  }
}


