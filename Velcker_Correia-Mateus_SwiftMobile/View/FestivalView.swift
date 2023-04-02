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
    NavigationView(){
      VStack() {
        VStack(alignment: .leading){
          if(cbon){
            JourListView(festival: self.festival)
          }
        }
        VStack(alignment: .center){
          if(authentification.is_admin) {
            Button(action: {
              intentFestival.openOrClose(token: authentification.token)
            }) {
              Image(systemName: "lock.fill")
                .foregroundColor(Color(.systemRed))
              Text("\(festival.is_active ? "Clôturer le festival ?" : "Rouvrir le festival ?")")
                .foregroundColor(Color(.systemRed))
            }
          }
        }
      }.navigationBarBackButtonHidden(true)
        .navigationTitle(nom)
      .onAppear {
        Task {
          try? await Task.sleep(nanoseconds: 500_000_000) // 1 seconde = 1_000_000_000
          cbon = true
        }
      }
    }
    
  }
}
