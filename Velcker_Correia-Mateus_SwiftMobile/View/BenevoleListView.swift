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
          Picker("Créneaux", selection: $benevoleListVM.selectionCreneau) {
            ForEach(benevoleListVM.creneauList, id:\.self) {
              Text("\($0.debut.toString()) - \($0.fin.toString())").tag($0.id_creneau)
            }
          }
          Button("Chercher par créneau") {
            searchByCreneau = true
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
              CreneauBenevoleView(creneau: benevoleListVM.creneauList.first(where: {$0.id_creneau == benevoleListVM.selectionCreneau})!, zone: z, jour: Jour(id: -1, id_festival: -1, nom: "J1", ouverture: Date.now, fermeture: Date.now), benevoleList: benevoleListVM.benevoleList)
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
      }
    }
  }
}


