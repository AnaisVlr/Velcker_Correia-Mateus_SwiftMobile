//
//  AddBenevoleView.swift
//  Velcker_Correia-Mateus_SwiftMobile
//
//  Created by Pain des bites on 02/04/2023.
//

import Foundation
import SwiftUI

struct AddBenevoleView : View {
  @EnvironmentObject var authentification: Authentification
  @Environment(\.dismiss) private var dismiss
  
  @State var nom: String
  @State var prenom: String
  @State var email: String
  
  init() {
    self._nom = State(initialValue: "Nom bénévole")
    self._prenom = State(initialValue: "Prénom Bénvole")
    self._email = State(initialValue: "Email bénévole")
  }

  var body: some View {
    NavigationView {
      VStack(){
        VStack(alignment: .leading){
          Text("Nom : ")
            .bold()
          TextField("", text: $nom)
            .textFieldStyle(.roundedBorder)
          Text("Prénom : ")
            .bold()
          TextField("", text: $prenom)
            .textFieldStyle(.roundedBorder)
          Text("Email : ")
            .bold()
          TextField("", text: $email)
            .textFieldStyle(.roundedBorder)
        }.padding()
        Spacer().frame(height: 50)
        VStack(alignment: .center){
          Button("Créer un bénévole") {
            BenevoleService().create(token: authentification.token, email: self.email, nom: self.nom, prenom: self.prenom, password: "123"){ res in
                switch res {
                case .success(_):
                    break
                case .failure(let error):
                    print(error)
                }
            }
          }
          .padding()
          .border(Color("AccentColor"))
          .cornerRadius(10)
          .overlay(
                 RoundedRectangle(cornerRadius: 10)
                     .stroke(Color("AccentColor"), lineWidth: 2)
             )
          Button("Retour"){
            self.dismiss()
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
    }.navigationBarBackButtonHidden(true)
  }
}
