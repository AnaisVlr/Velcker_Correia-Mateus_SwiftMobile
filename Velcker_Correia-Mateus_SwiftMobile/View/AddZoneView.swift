//
//  AddZoneView.swift
//  Velcker_Correia-Mateus_SwiftMobile
//
//  Created by Pain des bites on 23/03/2023.
//

import SwiftUI

struct AddZoneView : View {
  @EnvironmentObject var authentification: Authentification
  @Environment(\.dismiss) private var dismiss
  
  @State var festival: FestivalViewModel
  
  @State var nom: String = "Nom"
  @State var nb_benevole: Int = 1
  
  init(festival: FestivalViewModel){
    self._festival = State(initialValue: festival)
  }

  var body: some View {
    HStack(alignment: .top) {
      NavigationView(){
        VStack(alignment :.leading){
          Button(action: {
            self.dismiss()
          }) {
            HStack{
              Spacer().frame(width : 15)
              Image(systemName: "arrowshape.turn.up.backward.fill")
              Text("Retour à la liste des zones")
            }
          }
          VStack(alignment: .center) {
            Text("Créer une zone")
            VStack() {
              Text("Nom de la zone")
              TextField("", text: $nom)
            }
            VStack() {
              Text("Nombre de bénévoles nécessaires")
              Picker("Benevole", selection: $nb_benevole) {
                ForEach((1...10).reversed(), id: \.self) {
                  Text(verbatim: "\($0)").tag($0)
                }
              }
            }
            Button("Créer") {
              let z: Zone = Zone(id: -1, id_festival: festival.id_festival, nom: nom, nb_benevole: nb_benevole)
              ZoneService().create(token: authentification.token, zone: z) { res in
                switch res {
                case .success(_):
                  DispatchQueue.main.async {
                    self.dismiss()
                  }
                case .failure(let error):
                  print(error)
                }
              }
            }.buttonStyle(CustomButton())
          }
        }
      }
    }
  }
}
