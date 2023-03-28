//
//  FestivalView.swift
//  Velcker_Correia-Mateus_SwiftMobile
//
//  Created by m1 on 21/03/2023.
//

import SwiftUI

struct FestivalView: View {
  @State var festival: FestivalIntent
  @EnvironmentObject var authentification: Authentification
  @Environment(\.dismiss) private var dismiss
  
  @State var nom: String
  
  init(festival: FestivalIntent) {
    self._festival = State(initialValue: festival)
      self._nom = State(initialValue: festival.getNom())
  }
  
  var body: some View {
    VStack(alignment: .leading) {
      NavigationLink("Jeux") {
      }
      NavigationLink("Jours") {
        JourListView()
      }
      NavigationLink("Zones") {
        ZoneListView(festival: festival)
      }
      if(authentification.is_admin) {
        NavigationLink("Bénévoles") {
          
        }
      }
      NavigationLink("Mes créneaux") {
        AffectationListView(festival: festival)
      }
      if(authentification.is_admin) {
        Button("Supprimer") {
          Task {
            FestivalService().delete(token: authentification.token, id_festival: festival.getId()) {res in
              switch res {
              case .success(let boolean):
                DispatchQueue.main.async {
                  self.dismiss()
                }
              case .failure(let error):
                print(error)
              }
            }
          }
        }
      }
    }.navigationBarBackButtonHidden(true)
      .navigationTitle(festival.getNom())
  }
}
