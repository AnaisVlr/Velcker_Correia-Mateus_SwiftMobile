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
  @StateObject var festivalList = FestivalListViewModel()
  
  var body: some View {
    NavigationView {
      VStack(alignment: .center) {
        
        Text("Liste des festivals")
        if(authentification.is_admin) {
          NavigationLink("Ajouter un festival") {
            AddFestivalView(liste: festivalList)
          }
        }
        List(festivalList.festivals) { f in
          VStack(alignment:.leading) {
            NavigationLink(f.getNom()) {
              FestivalView(festival: f)
            }
            Text("Sur \(f.getNbJour()) jour(s)")
          }
        }
        
      }.padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
        .onAppear {
          Task {
            FestivalService().getAll(token: authentification.token) {res in
              switch res {
              case .success(let festivals):
                festivalList.setFestivals(festivals!)
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
