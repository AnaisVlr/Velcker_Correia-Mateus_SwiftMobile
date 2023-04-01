//
//  ProfilView.swift
//  Velcker_Correia-Mateus_SwiftMobile
//
//  Created by Pain des bites on 31/03/2023.
//

import SwiftUI

struct ProfilView: View {
  @EnvironmentObject var authentification: Authentification
  
  @ObservedObject var benevole: BenevoleViewModel
  var intentBenevole: BenevoleIntent
  
  init(benevole : BenevoleViewModel) {
    self.benevole = benevole
    self.intentBenevole = BenevoleIntent(benevoleVM: benevole)
  }
  
  var body: some View {
    VStack{
      Button("Déconnexion") {
        Task {
          await authentification.updateValidation(success: false, token: "")
        }
      }
      VStack(alignment: .leading){
        Text("Mon profil")
        Text("Nom : \(benevole.nom)")
        Text("Prénom : \(benevole.prenom)")
        Text("Email : \(benevole.email)")
      }
    }
  }
}
