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
@StateObject var jourList = JourListViewModel()

var body: some View {
  NavigationView {
    VStack(alignment: .center) {
      
      Text("Liste des jours")
      if(authentification.is_admin) {
        NavigationLink("Ajouter un Jour") {
          
        }
      }
      List(jourList.jours) { j in
        VStack(alignment:.leading) {
          NavigationLink(j.getNom()) {
            JourView(jour: j)
          }
          Text("De ?? à ??")
        }
      }
      
    }.padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
      .onAppear {
        Task {
          /*JourService().getAll(token: authentification.token) {res in
            switch res {
            case .success(let jours):
              jourList.setJours(jours!)
            case .failure(let error):
              print(error)
            }
          }*/
        }
      }
  }.navigationBarBackButtonHidden(true)
    .navigationBarItems(leading: NavBackButton(dismiss: self.dismiss, texte: "Accueil"))
  
}
}
