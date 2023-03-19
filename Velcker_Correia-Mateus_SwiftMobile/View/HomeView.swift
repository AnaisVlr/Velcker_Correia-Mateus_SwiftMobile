//
//  Home.swift
//  Velcker_Correia-Mateus_SwiftMobile
//
//  Created by m1 on 18/03/2023.
//

import SwiftUI

struct HomeView: View {
  @EnvironmentObject var authentification: Authentification
  
  var body: some View {
    NavigationView {
      VStack(alignment: .center) {
        Text("Bonjour \(authentification.email)")
          .padding()

      }.padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
      .toolbar {
        ToolbarItem(placement: .navigationBarTrailing) {
          Button("Déconnexion") {
            Task {
              await authentification.updateValidation(success: false, token: "")
            }
          }
        }
      }
    }
    
  }
}
