//
//  AdminView.swift
//  Velcker_Correia-Mateus_SwiftMobile
//
//  Created by Pain des bites on 31/03/2023.
//

import SwiftUI

struct AdminView: View {
  @EnvironmentObject var authentification: Authentification
  
  @ObservedObject var benevoleListVM: BenevoleListViewModel
  var intentBenevoleList: BenevoleListIntent
  
  @State private var showAddBenevole = false
  
  init(){
    let bL = BenevoleListViewModel()
    self.benevoleListVM = bL
    self.intentBenevoleList = BenevoleListIntent(benevoleListVM: bL)
  }
  
  var body: some View {
    NavigationView(){
      VStack{
        VStack(alignment: .leading){
          Text("Liste des bénévoles existants :").bold().padding()
          List{
            ForEach(benevoleListVM.benevoleList) { b in
              VStack(alignment:.leading) {
                Text(b.prenom + " " + b.nom).bold()
                Text(b.email)
              }
            }.onDelete { indexSet in
              for i in indexSet {
                Task {
                  self.intentBenevoleList.delete(token: authentification.token, index: i)
                }
              }
            }
          }
        }
        VStack(alignment: .center){
          Button("Ajouter un bénévole") {
            showAddBenevole = true
          } .padding()
            .border(Color("AccentColor"))
            .cornerRadius(10)
            .overlay(
                   RoundedRectangle(cornerRadius: 10)
                       .stroke(Color("AccentColor"), lineWidth: 2)
               )
        }
      }.sheet(isPresented: $showAddBenevole) {
        AddBenevoleView()
      }
      .onAppear(){
        Task {
          intentBenevoleList.getBenevoleList(token: authentification.token)
        }
      }
    }
  }
}
