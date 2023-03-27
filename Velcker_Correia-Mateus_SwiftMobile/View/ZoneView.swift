//
//  ZoneView.swift
//  Velcker_Correia-Mateus_SwiftMobile
//
//  Created by Pain des bites on 23/03/2023.
//

import SwiftUI

struct ZoneView: View {
  @State var zone: ZoneIntent
  @EnvironmentObject var authentification: Authentification
  @Environment(\.dismiss) private var dismiss
  
  @State var nom: String
  @State var nb_benevole : Int
  
  init(zone: ZoneIntent) {
    self._zone = State(initialValue: zone)
    self._nom = State(initialValue: zone.getNom())
    self._nb_benevole = State(initialValue: zone.getNbrBenevole())
  }
  
  var body: some View {
    VStack(alignment: .leading) {
      TextField("", text: $nom)
      Picker("Benevole", selection: $nb_benevole) {
        ForEach((1...10).reversed(), id: \.self) {
          Text(verbatim: "\($0)").tag($0)
        }
      }
      Button("Supprimer ce festival") {
        Task {
          ZoneService().delete(token: authentification.token, id_zone: zone.getId()) {res in
            DispatchQueue.main.async {
              self.dismiss()
            }
          }
        }
      }
    }.navigationBarBackButtonHidden(true)
  }
}
