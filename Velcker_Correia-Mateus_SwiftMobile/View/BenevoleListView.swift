//
//  BenevoleListView.swift
//  Velcker_Correia-Mateus_SwiftMobile
//
//  Created by Pain des bites on 31/03/2023.
//

import SwiftUI

struct BenevoleListView: View {
  @EnvironmentObject var authentification: Authentification
  
  @ObservedObject var benevoleListVM: BenevoleListViewModel
  var intentBenevoleList: BenevoleListIntent
  
  @State var festival : FestivalViewModel
  
  init(festival : FestivalViewModel){
    self._festival = State(initialValue: festival)
    
    let bL = BenevoleListViewModel()
    self.benevoleListVM = bL
    self.intentBenevoleList = BenevoleListIntent(benevoleListVM: bL)
  }

  var body: some View {
    if(festival.is_active) {
      VStack(alignment: .leading) {
        HStack(alignment: .center) {
          Text("Liste des bénévoles présents au festival :")
        }.padding()
        List {
          ForEach(benevoleListVM.benevoleList) { b in
            VStack(alignment:.leading) {
              Text(b.prenom + " " + b.nom).bold()
              Text(b.email)
            }
          }
        }.frame(height: 550)
      }.onAppear(){
        Task {
          intentBenevoleList.getBenevoleByFestival(token:authentification.token, id_festival: festival.id_festival)
        }
      }
    }
  }
}


