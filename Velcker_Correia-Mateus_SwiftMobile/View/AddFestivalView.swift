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
  @State var jours: [JourViewModel] = [JourViewModel(model: Jour(id: -1, id_festival: -1, nom: "NomJour", ouverture: Date.now, fermeture: Date.now))]
  
  @State var nom: String = "Nom"
  @State var annee: Int = 2023
  @State var nb_jour: Int = 1
  @State var selecteItem: JourViewModel?

  var body: some View {
    NavigationView {
      HStack(alignment: .top) {
        VStack(alignment: .center) {
          Button(action: {
            self.dismiss()
          }) {
            HStack{
              Spacer().frame(width : 15)
              Image(systemName: "arrowshape.turn.up.backward.fill")
              Text("Retour à la liste des festivals")
            }
          }
          
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
              }.onChange(of: nb_jour) { tag in
                while(jours.count > tag) {
                  jours.removeLast()
                }
                while(jours.count < tag) {
                  jours.append(JourViewModel(model: Jour(id: -1, id_festival: -1, nom: "NomJour", ouverture: Date.now, fermeture: Date.now)))
                }
              }
            }
          }
          
          //Jours
          List {
            ForEach(jours) { j in
              Button(action: {selecteItem = j}) {
                VStack(alignment: .leading) {
                  Text("\(j.nom) : \(j.ouverture.toStringAvantCreate())-\(j.fermeture.toStringAvantCreate())")
                  Text("Avec \(j.creneauxList.count > 0 ? j.creneauxList.count : 1) créneau(x)")
                }
              }
            }.sheet(item: $selecteItem) {item in
              AddJourView(festival: FestivalViewModel(model: Festival(id: -1, nom: "", annee: 0, nombre_jour: 0, is_active: true)), liste: nil, jour: item)
            }
          }
          
          //Créer le festival
          Button("Créer") {
            let f: Festival = Festival(id: -1, nom: nom, annee: annee, nombre_jour: nb_jour, is_active: true)
            FestivalService().create(token: authentification.token, festival: f, jours: jours) { res in
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
          }.buttonStyle(CustomButton())
        }
      }
    }
  }
}
