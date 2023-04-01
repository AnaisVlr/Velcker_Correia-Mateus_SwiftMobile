//
//  AddJeuView.swift
//  Velcker_Correia-Mateus_SwiftMobile
//
//  Created by m1 on 01/04/2023.
//

import SwiftUI

struct AddJeuView : View {
  @EnvironmentObject var authentification: Authentification
  @Environment(\.dismiss) private var dismiss
  
  var liste: JeuListViewModel
  var festival: FestivalViewModel
  
  @State var nom: String = "NomJeu"
  @State var type: String = "ENFANT"
  
  init(liste: JeuListViewModel, festival: FestivalViewModel){
    self.festival = festival
    self.liste = liste
  }

  var body: some View {
    NavigationView {
      VStack(alignment: .center) {
        Text("Créer un jeu")
        VStack() {
          Text("Nom du jeu")
          TextField("", text: $nom)
        }
        VStack() {
          Text("Type du jeu")
          Picker("Type", selection: $type) {
            Text("ENFANT")
            Text("FAMILLE")
            Text("AMBIANCE")
            Text("INTITIE")
            Text("EXPERT")
          }
        }
        Button("Créer") {
          let j: Jeu = Jeu(id: -1,  nom: nom, type: type, id_festival: festival.id_festival)
          JeuService().create(token: authentification.token, jeu: j) { res in
           
          }
        }
      }
    }.navigationBarBackButtonHidden(true)
      .toolbar {
      ToolbarItem(placement: .navigationBarLeading) {
        NavBackButton(dismiss: self.dismiss, texte: "Retour")
      }
    }
  }
}
