//
//  JeuView.swift
//  Velcker_Correia-Mateus_SwiftMobile
//
//  Created by m1 on 01/04/2023.
//

import SwiftUI

struct JeuView: View {
  @EnvironmentObject var authentification: Authentification
  @Environment(\.dismiss) private var dismiss
  
  @ObservedObject var jeu: JeuViewModel
  var intentJeu: JeuIntent
  
  @State var nom: String
  
  init(jeu: JeuViewModel) {
    self.jeu = jeu
    self.intentJeu = JeuIntent(jeuVM: jeu)
    self._nom = State(initialValue: jeu.nom)
  }
  
  var body: some View {
    ZStack() {
      VStack(alignment: .leading) {
        TextField("", text:$nom)
      }.navigationBarBackButtonHidden(true)
        .navigationTitle(jeu.nom)
    }.navigationBarBackButtonHidden(true)
      .toolbar {
      ToolbarItem(placement: .navigationBarLeading) {
        NavBackButton(dismiss: self.dismiss, texte: "Retour")
      }
    }
  }
}

