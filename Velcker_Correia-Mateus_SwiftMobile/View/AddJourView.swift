//
//  AddJourView.swift
//  Velcker_Correia-Mateus_SwiftMobile
//
//  Created by m1 on 29/03/2023.
//

import SwiftUI

struct AddJourView : View {
  @EnvironmentObject var authentification: Authentification
  @Environment(\.dismiss) private var dismiss
    
  var liste: JourListViewModel
  let festival: FestivalIntent
  
  @State var nom: String = "Nom"
  @State var ouverture: Date = Date.now
  @State var fermeture: Date = Date.now

  var body: some View {
    NavigationView {
      VStack(alignment: .center) {
        
        Text("Créer un jour")
        
        VStack() {
          TextField("", text: $nom)
          DatePicker(
            "Ouverture",
            selection: $ouverture,
            displayedComponents: [.hourAndMinute]
          )
          DatePicker(
            "Fermeture",
            selection: $ouverture,
            displayedComponents: [.hourAndMinute]
          )
        }
        Button("Créer") {
          let j: Jour = Jour(id: -1, id_festival: self.festival.getId(), nom: nom, ouverture: ouverture, fermeture: fermeture)
          JourService().create(token: authentification.token, jour: j) { res in
            switch res {
            case .success(let jour):
              self.liste.appendJour(jour)//Pas nécessaire car le onAppear de la listeView refetch
              DispatchQueue.main.async {
                self.dismiss()
              }
            case .failure(let error):
              print(error)
            }
          }
        }
      }
    }.navigationBarBackButtonHidden(true)
  }
}
