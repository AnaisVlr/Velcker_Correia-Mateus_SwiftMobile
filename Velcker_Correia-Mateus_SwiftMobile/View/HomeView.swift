//
//  Home.swift
//  Velcker_Correia-Mateus_SwiftMobile
//
//  Created by m1 on 18/03/2023.
//

import SwiftUI

struct HomeView: View {
  @EnvironmentObject var authentification: Authentification
  
  @ObservedObject var benevole: BenevoleViewModel
  var intentBenevole: BenevoleIntent
  
  init(benevole : BenevoleViewModel) {
    self.benevole = benevole
    self.intentBenevole = BenevoleIntent(benevoleVM: benevole)
  }
  
  var body: some View {
    NavigationView(){
      VStack{
        VStack(){
          Text("Mes créneaux : ")
          Text("Trier par festival : ")
        }
      }.navigationTitle("Bonjour \(benevole.prenom) !")
    }
  }
}

