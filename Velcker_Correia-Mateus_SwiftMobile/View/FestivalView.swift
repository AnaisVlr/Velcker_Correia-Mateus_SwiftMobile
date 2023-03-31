//
//  FestivalView.swift
//  Velcker_Correia-Mateus_SwiftMobile
//
//  Created by m1 on 21/03/2023.
//

import SwiftUI

struct FestivalView: View {
  @EnvironmentObject var authentification: Authentification
  @Environment(\.dismiss) private var dismiss
  
  @ObservedObject var festival: FestivalViewModel
  var intentFestival: FestivalIntent
  
  @State var nom: String
  
  init(festival: FestivalViewModel) {
    self.festival = festival
    self.intentFestival = FestivalIntent(festivalVM: festival)
    self._nom = State(initialValue: festival.nom)
  }
  
  var body: some View {
    VStack(alignment: .leading) {
      NavigationLink("Jeux") {
      }
      NavigationLink("Jours") {
        JourListView(festival: self.festival)
      }
      NavigationLink("Zones") {
        ZoneListView(festival: festival)
      }
      if(authentification.is_admin) {
        NavigationLink("Bénévoles") {
          
        }
        Button("\(festival.is_active ? "Clôturer " : "Ouvrir")") {
          intentFestival.openOrClose(token: authentification.token)
        }
      }
      NavigationLink("Mes créneaux") {
        AffectationListView(festival: festival)
      }
      
    }.navigationBarBackButtonHidden(true)
      .navigationTitle(festival.nom)
  }
}
