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
  
  let festival: FestivalViewModel

  init(festival: FestivalViewModel) {
    let jl = JourListViewModel()
    self.jourList = jl
    self.intentListJour = JourListIntent(jourListVM: jl)
    self.festival = festival
  }
  
  var body: some View {
    ZStack() { //Empêche le onAppear de se faire 2 fois
      NavigationView {
        VStack(alignment: .center) {
          switch self.jourList.state {
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
          
          Text("Liste des jours")
          if(authentification.is_admin && festival.is_active) {
            NavigationLink("Ajouter un Jour") {
              AddJourView(festival: self.festival, liste: self.jourList, jour: nil)
            }.buttonStyle(CustomButton())
          }
          List {
            ForEach(jourList.jourList) { j in
              VStack(alignment:.leading) {
                NavigationLink(j.nom) {
                  JourView(jour: j)
                }.buttonStyle(CustomButton())
                Text("De \(j.ouverture.toString()) à \(j.fermeture.toString())")
              }
            }.onDelete { indexSet in
              for i in indexSet { //Pour récupérer l'objet supprimé
                Task {
                  self.intentListJour.delete(token: authentification.token, index: i)
                }
              }
            }.deleteDisabled(!authentification.is_admin || jourList.jourList.count <= 1  || !festival.is_active)
          }.frame(height: 400)
          
        }.padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
        
      }.onAppear {
        Task {
          intentListJour.getJourListByFestivalId(token: authentification.token, id_festival: festival.id_festival)
        }
      }
    }
  }
}
