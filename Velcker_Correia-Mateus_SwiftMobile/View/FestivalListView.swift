//
//  FestivalListView.swift
//  Velcker_Correia-Mateus_SwiftMobile
//
//  Created by m1 on 19/03/2023.
//

import SwiftUI

struct FestivalListView: View {
  @EnvironmentObject var authentification: Authentification
  @Environment(\.dismiss) private var dismiss
  
  @ObservedObject var festivalList: FestivalListViewModel
  var intentListFestival: FestivalListIntent
  
  @State private var showAddFestival = false
  
  init() {
    let fl = FestivalListViewModel()
    self.festivalList = fl
    self.intentListFestival = FestivalListIntent(festivalListVM: fl)
  }
  
  var body: some View {
    HStack(alignment: .top){
      NavigationView {
        VStack(alignment: .leading) {
          VStack{
            if(authentification.is_admin) {
              Button(action: {
                showAddFestival = true
              }) {
                HStack{
                  Spacer().frame(width: 15)
                  Text("Ajouter un festival")
                  Image(systemName: "plus.circle.fill")
                }
              }
            }
          }.sheet(isPresented: $showAddFestival) {
            AddFestivalView(liste: festivalList)
          }
          
          Text("Liste des festivals:")
            .bold()
            .padding()
          
          switch self.festivalList.state {
          case .loading:
            CircleLoader()
          case .deleting:
            CircleLoader()
          case .ready:
            List {
              ForEach(festivalList.festivalList) { f in
                VStack(alignment:.leading) {
                  let str = f.is_active ? f.nom : "(Clôturé) \(f.nom)"
                  NavigationLink(str) {
                    MenuFestivalView(festival: f)
                  }.buttonStyle(CustomButton())
                  Text("Sur \(f.nombre_jour) jour(s)")
                }
              }.onDelete { indexSet in
                for i in indexSet { //Pour récupérer l'objet supprimé
                  Task {
                    self.intentListFestival.delete(token: authentification.token, index: i)
                  }
                }
              }.deleteDisabled(!authentification.is_admin)
            }.frame(height: 600)
          case .errorLoading:
            Text("Erreur Chargement")
          case .errorDeleting:
            Text("Erreur Suppression")
          }
        }
          .onAppear {
            Task {
              intentListFestival.getFestivalList(token: authentification.token)
            }
          }
      }
    }
  }
}
