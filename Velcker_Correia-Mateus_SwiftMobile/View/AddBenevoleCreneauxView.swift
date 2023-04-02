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
  
  @State var zone : Zone
  @State var creneau : Creneau
  @State var benevoleList : [Benevole]
  @State var jour : Jour
  
  @State var benevoleSelected : Benevole? = nil
  
  init(zone: Zone, creneau: Creneau, benevoleList: [Benevole], jour: Jour) {
    let VM : AddBenevoleZoneViewModel = AddBenevoleZoneViewModel(benevoleList: benevoleList, jour: jour, zone: zone, creneau: creneau)
    self.addBZVM = VM
    self.intentAddBZ = AddBZIntent(addBZVM: VM)
    
    self._zone = State(initialValue: zone)
    self._creneau = State(initialValue: creneau)
    self._benevoleList = State(initialValue: benevoleList)
    self._jour = State(initialValue: jour)
  }
  
  var body: some View {
    VStack(alignment: .leading) {
      VStack{
        Text("Ajouter un bénévole à ce créneaux :")
      }
      VStack() {
        Text("Jour : \(jour.nom)")
        Text("Créneau : \(creneau.debut.toString()) - \(creneau.fin.toString())")
        Text("Zone : \(zone.nom)")
      }
      
      VStack() {
        Text("Bénevole :")
        Picker("Benévole", selection: $benevoleSelected) {
          ForEach(benevoleList, id: \.id) {
            Text($0.prenom)
          }
        }
      }
    
    
      Button("S'affecter") {
        Task {
          intentAddBZ.add(token: authentification.token, id_benevole: benevoleSelected!.id)
        }
      }
    }
  }
}
