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
      if(authentification.is_admin) {
        Button("\(festival.is_active ? "Cliquer ici pour clôturer le festival" : "Cliquer ici pour ouvrir le festival")") {
          intentFestival.openOrClose(token: authentification.token)
        }
      }
      JourListView(festival: self.festival)
    }.navigationBarBackButtonHidden(true)
      .navigationTitle(festival.nom)
  }
}
