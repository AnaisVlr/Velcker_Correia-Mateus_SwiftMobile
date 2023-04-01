//
//  ContentView.swift
//  Velcker_Correia-Mateus_SwiftMobile
//
//  Created by m1 on 14/03/2023.
//

import SwiftUI

struct ContentView: View {
  @StateObject var authenficiation = Authentification()
  
  var body: some View {

    if(authenficiation.isValidated) {
      MenuView()
      .environmentObject(authenficiation)
    }
    else {
      AuthView()
      .environmentObject(authenficiation)
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
      ContentView()
  }
}
