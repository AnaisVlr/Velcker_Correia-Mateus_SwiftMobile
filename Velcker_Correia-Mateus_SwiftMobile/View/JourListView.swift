//
//  JourListView.swift
//  Velcker_Correia-Mateus_SwiftMobile
//
//  Created by m1 on 28/03/2023.
//

import SwiftUI

struct JourListView: View {
  @EnvironmentObject var authentification: Authentification
  @Environment(\.dismiss) private var dismiss
    
  @ObservedObject var jourList = JourListViewModel()
  var intentListJour: JourListIntent
  
  @State private var showAddJour = false
  @State private var showJour = false
  
  let festival: FestivalViewModel

  init(festival: FestivalViewModel) {
    let jl = JourListViewModel()
    self.jourList = jl
    self.intentListJour = JourListIntent(jourListVM: jl)
    self.festival = festival
  }
  
  var body: some View {
    VStack(alignment: .leading) {
      VStack(){
        if(authentification.is_admin && festival.is_active) {
          HStack{
            Button(action: {
              showAddJour = true
            }) {
              Spacer().frame(width: 15)
              Text("Ajouter un jour")
              Image(systemName: "plus.circle.fill")
            }
          }
        }
      }
      VStack(alignment: .leading){
        Text("Liste des jours : ")
          .bold()
          .padding()
      }
      switch self.jourList.state {
      case .loading:
        CircleLoader()
      case .deleting:
        CircleLoader()
      case .ready:
        List {
          ForEach(jourList.jourList) { j in
            VStack(alignment:.leading) {
              Button(action: {
                showJour = true
              }) {
                HStack{
                  VStack(alignment: .leading){
                    Text(j.nom).bold()
                    Text("De \(j.ouverture.toString()) à \(j.fermeture.toString())")
                  }
                  Spacer()
                  Image(systemName: "eye.fill")
                }
              }
            }.sheet(isPresented: $showJour) {
              JourView(jour: j)
            }
          }.onDelete { indexSet in
            for i in indexSet { //Pour récupérer l'objet supprimé
              Task {
                self.intentListJour.delete(token: authentification.token, index: i)
              }
            }
          }.deleteDisabled(!authentification.is_admin || jourList.jourList.count <= 1  || !festival.is_active)
        }.frame(height: 400)
      case .errorLoading:
        Text("Erreur Chargement")
      case .errorDeleting:
        Text("Erreur Suppression")
      }
    }.sheet(isPresented: $showAddJour) {
      AddJourView(festival: self.festival, liste: self.jourList, jour: nil)
    }
    .onAppear {
      Task {
        intentListJour.getJourListByFestivalId(token: authentification.token, id_festival: festival.id_festival)
      }
    }
  }
}
