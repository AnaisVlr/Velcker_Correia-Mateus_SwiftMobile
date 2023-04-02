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
  
  @State private var showAddZone = false
  
  @State var festival : FestivalViewModel
  
  init(festival : FestivalViewModel){
    self._festival = State(initialValue: festival)
    
    let zl = ZoneListViewModel()
    self.zoneListMV = zl
    self.intentListZone = ZoneListIntent(zoneListVM: zl)
  }

  var body: some View {
    HStack(alignment: .top){
      NavigationView {
        VStack(alignment: .leading){
          VStack{
            if(authentification.is_admin && festival.is_active) {
              Button(action: {
                showAddZone = true
              }) {
                HStack{
                  Spacer().frame(width: 15)
                  Text("Ajouter une zone")
                  Image(systemName: "plus.circle.fill")
                }
              }
            }
          }.sheet(isPresented: $showAddZone) {
            AddZoneView(festival: self.festival)
          }
          Text("Liste des zones :")
            .bold()
            .padding()
          switch self.zoneListMV.state {
          case .loading:
            CircleLoader()
          case .deleting:
            CircleLoader()
          case .ready:
            List {
              ForEach(zoneListMV.zoneList) { z in
                VStack(alignment:.leading) {
                  NavigationLink(z.nom) {
                    ZoneView(zone: z)
                  }.buttonStyle(CustomButton())
                }
              }.onDelete { indexSet in
                for i in indexSet { //Pour récupérer l'objet supprimé
                  Task {
                    intentListZone.delete(token: authentification.token, index: i)
                  }
                }
              }.deleteDisabled(!authentification.is_admin || zoneListMV.zoneList.count <= 1 || !festival.is_active)
            }
          case .errorLoading:
            Text("Erreur Chargement")
          case .errorDeleting:
            Text("Erreur Suppression")
          }
        }.navigationTitle(festival.nom)
        .onAppear {
          Task {
            intentListZone.getZoneList(token: authentification.token, id_festival: festival.id_festival)
          }
        }
      }
    }
  }
}
