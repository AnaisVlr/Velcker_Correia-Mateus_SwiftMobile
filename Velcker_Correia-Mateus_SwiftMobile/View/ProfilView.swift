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
  
  @State var nom : String
  @State var prenom : String
  @State var email : String
  
  init(benevole : BenevoleViewModel) {
    self.benevole = benevole
    self.intentBenevole = BenevoleIntent(benevoleVM: benevole)
    
    self._nom = State(initialValue: benevole.nom)
    self._prenom = State(initialValue: benevole.prenom)
    self._email = State(initialValue: benevole.email)
  }
  
  var body: some View {
    NavigationView(){
      VStack(){
        VStack(alignment: .leading){
          Text("Nom : ")
            .bold()
          TextField("\(benevole.nom)", text: $nom)
            .textFieldStyle(.roundedBorder)
          Text("Prénom : ")
            .bold()
          TextField(benevole.prenom, text: $prenom)
            .textFieldStyle(.roundedBorder)
          Text("Email : ")
            .bold()
          TextField(benevole.email, text: $email)
            .textFieldStyle(.roundedBorder)
        }
        Spacer().frame(height: 50)
        VStack(alignment: .center){
          Button("Modifier mes informations") {
            let b : Benevole = Benevole(id: benevole.id_benevole, prenom: self.prenom, nom: self.nom, email: self.email, isAdmin: benevole.isAdmin)
            BenevoleService().modify(token: authentification.token, benevole: b) { res in
              print(res)
            }
          }
          .padding()
          .border(Color("AccentColor"))
          .cornerRadius(10)
          .overlay(
                 RoundedRectangle(cornerRadius: 10)
                     .stroke(Color("AccentColor"), lineWidth: 2)
             )
        }
      }
      .padding()
      .navigationTitle("Mon profil")
      .toolbar{
        Button("Déconnexion") {
          Task {
            await authentification.updateValidation(success: false, token: "")
          }
        }
      }
    }
  }
}
