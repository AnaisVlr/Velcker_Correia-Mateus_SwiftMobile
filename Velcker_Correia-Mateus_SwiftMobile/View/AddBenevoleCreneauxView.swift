//
//  AddBenevoleCreneaux.swift
//  Velcker_Correia-Mateus_SwiftMobile
//
//  Created by Pain des bites on 02/04/2023.
//

import SwiftUI

struct AddBenevoleCreneauxView: View {
  @EnvironmentObject var authentification: Authentification
  @Environment(\.dismiss) private var dismiss
  
  @ObservedObject var addBZVM: AddBenevoleZoneViewModel
  var intentAddBZ: AddBZIntent
  
  init(zone: Zone, creneau: Creneau, benevoleList: [Benevole], jour: Jour) {
    let VM : AddBenevoleZoneViewModel = AddBenevoleZoneViewModel(benevoleList: benevoleList, jour: jour, zone: zone, creneau: creneau)
    self.addBZVM = VM
    self.intentAddBZ = AddBZIntent(addBZVM: VM)
  }
  
  var body: some View {
    VStack(alignment: .leading) {
      VStack{
        Text("Ajouter un bénévole à ce créneaux :")
      }
      VStack() {
        Text("Jour : \(addBZVM.jour.nom)")
        Text("Créneau : \(addBZVM.creneau.debut.toString()) - \(addBZVM.creneau.fin.toString())")
        Text("Zone : \(addBZVM.zone.nom)")
      }
      
      VStack() {
        if(addBZVM.selectedBenevole != -1) {
          Text("Bénévole :")
          Picker("Bénévole", selection: $addBZVM.selectedBenevole) {
            ForEach(addBZVM.benevoleList) { b in
              Text("\(b.prenom) \(b.nom)").tag(b.id)
            }
          }
        }
        
      }
    
      Button("Affecter") {
        Task {
          intentAddBZ.add(token: authentification.token)
        }
      }
    }.onAppear {
      Task {
        intentAddBZ.getBenevoleList(token: authentification.token)
      }
    }
  }
}
