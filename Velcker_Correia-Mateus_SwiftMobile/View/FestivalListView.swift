//
//  FestivalListView.swift
//  Velcker_Correia-Mateus_SwiftMobile
//
//  Created by m1 on 19/03/2023.
//

import SwiftUI

struct FestivalListView: View {
  @EnvironmentObject var authentification: Authentification
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
          VStack(alignment:.leading) { //Mettre des NavigationLink
            Text(f.nom)
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
    }
    
  }
}
