//
//  CreneauBenevoleView.swift
//  Velcker_Correia-Mateus_SwiftMobile
//
//  Created by m1 on 02/04/2023.
//

import SwiftUI
import Foundation

struct CreneauBenevoleView: View {
  @EnvironmentObject var authentification: Authentification
  
  @ObservedObject var creneauBenevolVM: CreneauBenevoleViewModel
  var intentCB: CreneauBenevoleIntent
  
  @State var benevoleList : [BenevoleViewModel]
  
  @State private var showAddBenevoleInZone = false
  
  init(creneau: Creneau, zone: Zone, jour: Jour, benevoleList : [BenevoleViewModel]) {
    let cbVM = CreneauBenevoleViewModel(creneau: creneau, zone: zone, jour: jour)
    self.creneauBenevolVM = cbVM
    self.intentCB = CreneauBenevoleIntent(creneauBenevoleVM: cbVM)
    self.benevoleList = benevoleList
  }
  
  var body: some View {
    VStack() {
      if creneauBenevolVM.benevoleList.count < creneauBenevolVM.zone.nb_benevole{
        Text("\(creneauBenevolVM.zone.nom) : \(creneauBenevolVM.benevoleList.count) sur \(creneauBenevolVM.zone.nb_benevole)")
          .foregroundColor(Color(.red))
      }else{
        Text("\(creneauBenevolVM.zone.nom) : \(creneauBenevolVM.benevoleList.count) sur \(creneauBenevolVM.zone.nb_benevole)")
          .foregroundColor(Color(.systemGreen))
      }
      HStack{
        Button(action: {
          showAddBenevoleInZone = true
          }) {
            Image(systemName: "person.fill.badge.plus")
          }
      }
      List {
        ForEach(creneauBenevolVM.benevoleList, id:\.id) {
          Text("\($0.prenom) \($0.nom)")
        }.onDelete { indexSet in
          for i in indexSet {
            Task {
              self.intentCB.delete(token: authentification.token, index: i)
            }
          }
        }
      }.frame(height: 50*CGFloat(creneauBenevolVM.benevoleList.count > 0 ? creneauBenevolVM.benevoleList.count+1 : 0), alignment: .center)
    }.sheet(isPresented: $showAddBenevoleInZone) {
      AddBenevoleCreneauxView(zone: creneauBenevolVM.zone, creneau: creneauBenevolVM.creneau, benevoleList: creneauBenevolVM.benevoleList, jour: creneauBenevolVM.jour)
    }
    .onAppear {
      Task {
        intentCB.getBenevoleList(token: authentification.token)
      }
    }
  }
}
