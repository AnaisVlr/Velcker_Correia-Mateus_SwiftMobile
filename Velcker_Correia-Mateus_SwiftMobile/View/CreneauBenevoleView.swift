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
  
  init(creneau: Creneau, zone: Zone) {
    let cbVM = CreneauBenevoleViewModel(creneau: creneau, zone: zone)
    self.creneauBenevolVM = cbVM
    self.intentCB = CreneauBenevoleIntent(creneauBenevoleVM: cbVM)
  }
  
  var body: some View {
    VStack() {
      Text("\(creneauBenevolVM.zone.nom) : \(creneauBenevolVM.benevoleList.count) sur \(creneauBenevolVM.zone.nb_benevole)")
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
    }.onAppear {
      Task {
        intentCB.getBenevoleList(token: authentification.token)
      }
    }
  }
}
