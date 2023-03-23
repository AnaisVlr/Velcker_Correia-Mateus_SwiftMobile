//
//  ZoneView.swift
//  Velcker_Correia-Mateus_SwiftMobile
//
//  Created by Pain des bites on 23/03/2023.
//

import SwiftUI

struct ZoneView: View {
  @State var zone: ZoneViewModel
  @Environment(\.dismiss) private var dismiss
  
  @State var nom: String
  @State var nb_benevole : Int
  
  init(zone: ZoneViewModel) {
    self._zone = State(initialValue: zone)
    self._nom = State(initialValue: zone.nom)
    self._nb_benevole = State(initialValue: zone.nb_benevole)
  }
  
  var body: some View {
    VStack(alignment: .leading) {
      TextField("", text: $nom)
      Picker("Benevole", selection: $nb_benevole) {
        ForEach((1...10).reversed(), id: \.self) {
          Text(verbatim: "\($0)").tag($0)
        }
      }
    }.navigationBarBackButtonHidden(true)
  }
}
