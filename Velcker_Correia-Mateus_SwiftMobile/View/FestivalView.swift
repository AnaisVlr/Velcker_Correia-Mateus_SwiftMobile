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
      TextField("", text: $nom)
      Button("Supprimer") {
        Task {
          FestivalService().delete(token: authentification.token, id_festival: festival.getId()) {success in
            DispatchQueue.main.async {
              self.dismiss()
            }
          }
        }
      }
      NavigationLink("Voir les zones du festival") {
        ZoneListView(festival: festival)
      }
    }.navigationBarBackButtonHidden(true)
  }
}
