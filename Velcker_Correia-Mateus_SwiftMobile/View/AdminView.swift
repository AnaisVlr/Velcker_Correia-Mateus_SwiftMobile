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
    VStack(alignment: .leading){
      HStack(){
        Button(action: {
          showAddBenevole = true
        }) {
          Spacer().frame(width: 15)
          Text("Ajouter un bénévole")
          Image(systemName: "plus.circle.fill")
        }
      }
      VStack(){
        Text("Liste des bénévoles existants :")
          .bold()
          .padding()
      }
      VStack{
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
