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
  @State private var selected = 1
  
  init(festival: FestivalViewModel) {
    self.festival = festival
    self.intentFestival = FestivalIntent(festivalVM: festival)
    self._nom = State(initialValue: festival.nom)
  }
  
  var body: some View {
    ZStack(alignment: .bottom) {
      TabView(selection: $selected){
        FestivalView(festival: festival)
          .tabItem {
            Text("")
          }.tag(1)
        ZoneListView(festival: festival)
          .tabItem {
            Text("")
          }.tag(2)
        JeuxView()
          .tabItem {
          Text("")
        }.tag(3)
        if(authentification.is_admin) {
          BenevoleListView()
            .tabItem {
              Text("")
            }.tag(4)}
        AffectationListView(festival: festival)
          .tabItem {
          Text("")
        }.tag(5)
      }
      HStack {
        VStack(alignment: .leading) {
        Button(action: {self.selected = 1}) {
          Text("JOUR").foregroundColor( self.selected == 1 ? .accentColor : .gray)
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
        }
          
        }
        Button(action: {self.selected = 2}) {
          Text("ZONE").foregroundColor( self.selected == 2 ? .accentColor : .gray)
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
        }
        Button(action: {self.selected = 3}) {
          Text("JEU").foregroundColor( self.selected == 3 ? .accentColor : .gray)
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
        }
        if(authentification.is_admin) {
          Button(action: {self.selected = 4}) {
            Text("BENEVOLE").foregroundColor( self.selected == 4 ? .accentColor : .gray)
              .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
          }
        }
        Button(action: {self.selected = 5}) {
          Text("MES CRENEAUX").foregroundColor( self.selected == 5 ? .accentColor : .gray)
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
        }
      }
    }
    
  }
}
