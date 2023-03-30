//
//  ZoneListView.swift
//  Velcker_Correia-Mateus_SwiftMobile
//
//  Created by Pain des bites on 23/03/2023.
//

import SwiftUI

struct ZoneListView: View {
  @EnvironmentObject var authentification: Authentification
  @Environment(\.dismiss) private var dismiss
  
  
  @ObservedObject var zoneListMV: ZoneListViewModel
  var intentListZone: ZoneListIntent
  
  @State var festival : FestivalViewModel
  
  init(festival : FestivalViewModel){
    self._festival = State(initialValue: festival)
    
    let zl = ZoneListViewModel()
    self.zoneListMV = zl
    self.intentListZone = ZoneListIntent(zoneListVM: zl)
  }

  var body: some View {
    NavigationView {
      VStack(alignment: .center) {
        Text("Liste des zones")
          if(authentification.is_admin) {
            NavigationLink("Ajouter une zone") {
              AddZoneView(festival: self.festival)
            }
          }
        List {
          ForEach(zoneListMV.zoneList) { z in
            VStack(alignment:.leading) {
              NavigationLink(z.nom) {
                ZoneView(zone: z)
              }
            }
          }.onDelete { indexSet in
            for i in indexSet { //Pour récupérer l'objet supprimé
              Task {
                intentListZone.delete(token: authentification.token, index: i)
              }
            }
          }.deleteDisabled(!authentification.is_admin || zoneListMV.zoneList.count <= 1)
        }
        
      }.padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
        .onAppear {
          Task {
            intentListZone.getZoneList(token: authentification.token, id_festival: festival.id_festival)
          }
        }
    }.navigationBarBackButtonHidden(true)
  }
}
