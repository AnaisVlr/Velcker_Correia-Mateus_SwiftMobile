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
        if(authentification.is_admin) {
          Button("Ajouter un festival") {
            
          }
        }
        
      }.padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
        .onAppear {
          print("Festival List View Ouvert")
        }
    }
    
  }
}
