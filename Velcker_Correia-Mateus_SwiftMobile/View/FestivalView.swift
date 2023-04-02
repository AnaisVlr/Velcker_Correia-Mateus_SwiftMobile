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
  @State var cbon = false //Obligé car la liste disparaît après avoir chargé
  
  init(festival: FestivalViewModel) {
    
    self.festival = festival
    self.intentFestival = FestivalIntent(festivalVM: festival)
    self._nom = State(initialValue: festival.nom)
  }
  
  var body: some View {
    ZStack() {
      VStack(alignment: .leading) {
        if(authentification.is_admin) {
          Button("\(festival.is_active ? "Clôturer le festival" : "Rouvrir le festival")") {
            intentFestival.openOrClose(token: authentification.token)
          }.buttonStyle(CustomButton())
        }
        if(cbon){
          JourListView(festival: self.festival)
        }
      }.navigationBarBackButtonHidden(true)
        .navigationTitle(festival.nom)
    }
    .onAppear {
      Task {
        try? await Task.sleep(nanoseconds: 500_000_000) // 1 seconde = 1_000_000_000
        cbon = true
      }
      
    }
  }
}
