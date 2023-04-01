//
//  ZoneView.swift
//  Velcker_Correia-Mateus_SwiftMobile
//
//  Created by Pain des bites on 23/03/2023.
//

import SwiftUI

struct ZoneView: View {
  @EnvironmentObject var authentification: Authentification
  @Environment(\.dismiss) private var dismiss
  
  @ObservedObject var zone: ZoneViewModel
  var intentZone: ZoneIntent
    
  @State var nom: String
  @State var nb_benevole : Int
  @State var nb_benevole_present : Int
  
  init(zone: ZoneViewModel) {
    self.zone = zone
    self.intentZone = ZoneIntent(zoneVM: zone)
    self._nom = State(initialValue: zone.nom)
    self._nb_benevole = State(initialValue: zone.nb_benevole)
    self._nb_benevole_present = State(initialValue: 0)
  }
  
  var body: some View {
    VStack(alignment: .leading) {
      TextField("", text: $nom)
      Picker("Benevole", selection: $nb_benevole) {
        ForEach((1...10).reversed(), id: \.self) {
          Text(verbatim: "\($0)").tag($0)
        }
      }
      if(zone.nb_benevole_present >= zone.nb_benevole){
        Text("Il y a assez de bénévole dans cette zone")
      }else{
        Text("Il n'y a pas assez de bénévole pour cette zone !")
      }
      
    }.navigationBarBackButtonHidden(true)
      .toolbar {
      ToolbarItem(placement: .navigationBarLeading) {
        NavBackButton(dismiss: self.dismiss, texte: "Retour")
      }
    }
      .onAppear{
        Task{
          intentZone.getAllBenevole(token: authentification.token)
        }
      }
  }
}
