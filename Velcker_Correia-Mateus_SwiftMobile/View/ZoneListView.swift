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
  @StateObject var zoneListMV = ZoneListViewModel()
  
  @State var festival : FestivalViewModel
  
  init(festival : FestivalViewModel){
    self._festival = State(initialValue: festival)
  }

  var body: some View {
    NavigationView {
      VStack(alignment: .center) {
        Text("Liste des zones")
          if(authentification.is_admin) {
            NavigationLink("Ajouter une zone") {
              AddZoneView(festival: FestivalViewModel(model: festival.model))
            }
          }
        List(zoneListMV.zones) { z in
          VStack(alignment:.leading) {
            NavigationLink(z.nom) {
              ZoneView(zone: ZoneViewModel(model: z))
            }
          }
        }
      }.padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
        .onAppear {
          Task {
            ZoneService().getAll(token: authentification.token) {res in
              switch res {
                case .success(let zones):
                  zoneListMV.setZones(zones!)
                case .failure(let error):
                  print(error)
              }
            }
          }
        }
    }.navigationBarBackButtonHidden(true)
  }
}