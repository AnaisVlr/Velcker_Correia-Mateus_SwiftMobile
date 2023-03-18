//
//  AuthView.swift
//  Velcker_Correia-Mateus_SwiftMobile
//
//  Created by m1 on 14/03/2023.
//

import SwiftUI

struct AuthView: View {
  @State var identifiant : String = "dorian.752@live.fr"
  @State var password : String = "123"
  
  var body: some View {
    VStack(alignment: .center) {
      
      Text("Connexion")
        .padding()
      
      VStack(alignment: .center){
        TextField("", text: $identifiant)
          .textFieldStyle(.roundedBorder)
        SecureField("", text: $password)
          .textFieldStyle(.roundedBorder)
        
        Button {
          Task {
            let result: String = await AuthService.tryConnect(id: identifiant, pwd: password)
            print(result)
          }
         
        } label: {
          Text("Se connecter")
        }
        .padding()
        .background(Color(red:0, green: 0, blue: 0.5))
        .clipShape(Capsule())
      }.padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
    }
  }
}
