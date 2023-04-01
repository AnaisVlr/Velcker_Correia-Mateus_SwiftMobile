//
//  MenuView.swift
//  Velcker_Correia-Mateus_SwiftMobile
//
//  Created by Pain des bites on 31/03/2023.
//

import SwiftUI

struct MenuView: View {
  @EnvironmentObject var authentification: Authentification
  
  @ObservedObject var benevole: BenevoleViewModel
  var intentBenevole: BenevoleIntent

  
  init() {
    UITabBar.appearance().barTintColor = UIColor.white
    UITabBar.appearance().backgroundColor = UIColor.white
    let b = Benevole(id: -1, prenom: "ss", nom: "", email: "", isAdmin: false)
    let b1 = BenevoleViewModel(model: b)
    self.benevole = b1
    self.intentBenevole = BenevoleIntent(benevoleVM: b1)
  }
  
  var body: some View {
    ZStack() {
      if(benevole.id_benevole != -1) {
        TabView(){
          HomeView(benevole: benevole)
            .tabItem {
              Label("Accueil", systemImage: "house.fill")
            }
          if (authentification.is_admin) {
            AdminView()
              .tabItem{
                Label("Admin", systemImage: "lock")
              }
          }
          FestivalListView()
            .tabItem {
              Label("Festivals", systemImage: "flag.2.crossed.fill")
            }
          ProfilView(benevole: benevole)
            .tabItem{
              Label("Profil", systemImage: "person.fill")
            }
        }
      }
    } .onAppear{
      Task{
        intentBenevole.getBenevoleByEmail(token: authentification.token, email: authentification.email)
      }
    }
  }
}
