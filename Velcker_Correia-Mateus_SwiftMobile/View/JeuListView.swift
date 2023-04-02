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
  
  let festival: FestivalViewModel

  init(festival: FestivalViewModel) {
    let jl = JeuListViewModel()
    self.jeuList = jl
    self.intentListJeu = JeuListIntent(jeuListVM: jl)
    self.festival = festival
  }
  
  var body: some View {
    ZStack{
      NavigationView {
        VStack(alignment: .center) {
          switch self.jeuList.state {
          case .loading:
            CircleLoader()
          case .deleting:
            CircleLoader()
          case .ready:
            Text("")
          case .errorLoading:
            Text("Erreur Chargement")
          case .errorDeleting:
            Text("Erreur Suppression")
          }
          
          Text("Liste des Jeux")
          if(authentification.is_admin) {
            NavigationLink("Ajouter un Jeu") {
              AddJeuView(liste: jeuList, festival: festival)
            }.buttonStyle(CustomButton())
          }
          
          List {
            ForEach(jeuList.jeuList) { j in
              VStack(alignment:.leading) {
                NavigationLink(j.nom) {
                  JeuView(jeu: j)
                }.buttonStyle(CustomButton())
              }
            }.onDelete { indexSet in
              for i in indexSet { //Pour récupérer l'objet supprimé
                Task {
                  self.intentListJeu.delete(token: authentification.token, index: i)
                }
              }
            }.deleteDisabled(!authentification.is_admin)
          }
          
        }.padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
      }
    }.onAppear {
      Task {
        intentListJeu.getJeuList(token: authentification.token, id_festival: festival.id_festival)
      }
    }
  }
}

