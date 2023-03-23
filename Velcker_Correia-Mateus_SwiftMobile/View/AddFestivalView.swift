//
//  AddFestivalView.swift
//  Velcker_Correia-Mateus_SwiftMobile
//
//  Created by m1 on 22/03/2023.
//

import SwiftUI

struct AddFestivalView : View {
  @EnvironmentObject var authentification: Authentification
  @Environment(\.dismiss) private var dismiss
  var liste: FestivalListViewModel
  
  @State var nom: String = "Nom"
  @State var annee: Int = 2023
  @State var nb_jour: Int = 1

  var body: some View {
    NavigationView {
      VStack(alignment: .center) {
        
        Text("Créer un festival")
        
        VStack() {
          TextField("", text: $nom)
          VStack() {
            Text("Année :")
            Picker("Année", selection: $annee) {
              ForEach((2020...2050).reversed(), id: \.self) {
                Text(verbatim: "\($0)").tag($0)
              }
            }
          }
          VStack() {
            Text("Nombre de jours :")
            Picker("Jours", selection: $nb_jour) {
              ForEach((1...10).reversed(), id: \.self) {
                Text(verbatim: "\($0)").tag($0)
              }
            }
          }
        }
        Button("Créer") {
          let f: Festival = Festival(id: -1, nom: nom, annee: annee, nombre_jour: nb_jour, is_active: true)
          FestivalService().create(token: authentification.token, festival: f) { res in
            switch res {
            case .success(let festival):
              self.liste.appendFestival(festival) //Pas nécessaire car le onAppear de la listeView refetch
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
      .navigationBarItems(leading: NavBackButton(dismiss: self.dismiss, texte: "Retour aux festivals"))
  }
}
