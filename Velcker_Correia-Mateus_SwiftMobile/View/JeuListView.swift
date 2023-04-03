//
//  JeuListView.swift
//  Velcker_Correia-Mateus_SwiftMobile
//
//  Created by m1 on 01/04/2023.
//

import SwiftUI

struct JeuListView: View {
  @EnvironmentObject var authentification: Authentification
  @Environment(\.dismiss) private var dismiss
  
  @ObservedObject var jeuList: JeuListViewModel
  var intentListJeu: JeuListIntent
  
  @State private var showAddJeu = false
  
  let festival: FestivalViewModel

  init(festival: FestivalViewModel) {
    let jl = JeuListViewModel()
    self.jeuList = jl
    self.intentListJeu = JeuListIntent(jeuListVM: jl)
    self.festival = festival
  }
  
  var body: some View {
    HStack(alignment: .top){
      NavigationView {
        VStack(alignment: .leading) {
          VStack{
            if(authentification.is_admin && festival.is_active) {
              Button(action: {
                showAddJeu = true
              }) {
                HStack{
                  Spacer().frame(width: 15)
                  Text("Ajouter un jeu")
                  Image(systemName: "plus.circle.fill")
                }
              }
            }
          }.sheet(isPresented: $showAddJeu) {
            AddJeuView(liste: jeuList, festival: festival)
          }
          
          Text("Liste des jeux :")
            .bold()
            .padding()
          
          switch self.jeuList.state {
          case .loading:
            CircleLoader()
          case .deleting:
            CircleLoader()
          case .ready:
            List {
              ForEach(jeuList.jeuList) { j in
                VStack(alignment:.leading) {
                  Text("\(j.nom)")
                }
              }.onDelete { indexSet in
                for i in indexSet { //Pour récupérer l'objet supprimé
                  Task {
                    self.intentListJeu.delete(token: authentification.token, index: i)
                  }
                }
              }.deleteDisabled(!authentification.is_admin)
            }
          case .errorLoading:
            Text("Erreur Chargement")
          case .errorDeleting:
            Text("Erreur Suppression")
          }
        }.navigationTitle(festival.nom)
        .onAppear {
          Task {
            intentListJeu.getJeuList(token: authentification.token, id_festival: festival.id_festival)
          }
        }
      }
    }
  }
}

