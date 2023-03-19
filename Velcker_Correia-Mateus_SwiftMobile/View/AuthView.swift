//
//  AuthView.swift
//  Velcker_Correia-Mateus_SwiftMobile
//
//  Created by m1 on 14/03/2023.
//

import SwiftUI

struct AuthView: View {
  @StateObject private var authVM = AuthViewModel()
  @EnvironmentObject var authentification: Authentification
  
  var body: some View {
    VStack(alignment: .center) {
      
      Text("Connexion")
        .padding()
      
      VStack(alignment: .center){
        TextField("", text: $authVM.email)
          .keyboardType(.emailAddress)
          .textFieldStyle(.roundedBorder)
        SecureField("", text: $authVM.password)
          .textFieldStyle(.roundedBorder)
        
        Button("Se connecter") {
          authVM.login() { success in
            Task {
              await authentification.updateValidation(success: success, token: authVM.token)
            }
          }
        }
        .disabled(authVM.loginDisabled)
        .padding()
        .background(Color(red:0, green: 0, blue: 0.5))
        .clipShape(Capsule())
      }.padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
        .alert(item: $authVM.error) { error in
          Alert(title: Text("Connexion échouée"), message: Text(error.errorDescription ?? ""))
        }
    }
  }
}
