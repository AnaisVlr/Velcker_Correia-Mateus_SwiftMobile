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
  @StateObject var festivalListMV = FestivalListViewModel()
  
  var body: some View {
    NavigationView {
      VStack(alignment: .center) {
        
        Text("Liste des festivals")
        Button("Voir les zones") { //Faire des NavigationLink
          
        }
        if(authentification.is_admin) {
          Button("Ajouter un festival") {
            
          }
        }
        List(festivalListMV.festivals) { f in
          VStack(alignment:.leading) {
            NavigationLink(f.nom) {
              FestivalView(festival: FestivalViewModel(model: f))
            }
            Text("\(f.nombre_jour)")
          }
        }
        
      }.padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
        .onAppear {
          Task {
            FestivalService().getAll(token: authentification.token) {res in
              switch res {
              case .success(let festivals):
                festivalListMV.setFestivals(festivals!)
              case .failure(let error):
                print(error)
              }
            }
          }
          
        }
    }.navigationBarBackButtonHidden(true)
      .navigationBarItems(leading: NavBackButton(dismiss: self.dismiss, texte: "Accueil"))
    
  }
}
