//
//  MenuFestivalView.swift
//  Velcker_Correia-Mateus_SwiftMobile
//
//  Created by Pain des bites on 31/03/2023.
//

import SwiftUI

struct MenuFestivalView: View {
  @EnvironmentObject var authentification: Authentification
  
  @ObservedObject var festival: FestivalViewModel
  var intentFestival: FestivalIntent
  
  @State var nom: String
  
  init(festival: FestivalViewModel) {
    self.festival = festival
    self.intentFestival = FestivalIntent(festivalVM: festival)
    self._nom = State(initialValue: festival.nom)
  }
  
  var body: some View {
    TabView(){
      FestivalView(festival: festival)
        .tabItem {
          Label("Festival", systemImage: "house.fill")
        }
      ZoneListView(festival: festival)
        .tabItem {
          Label("Zones", systemImage: "door.right.hand.closed")
        }
      JeuxView()
        .tabItem{
          Label("Jeux", systemImage: "party.popper.fill")
        }
      if(authentification.is_admin) {
        BenevoleListView()
          .tabItem{
            Label("Bénévoles", systemImage: "person.3.fill")
          }      }
      AffectationListView(festival: festival)
        .tabItem{
          Label("Mes créneaux", systemImage: "clock.fill")
        }
    }
  }
}
