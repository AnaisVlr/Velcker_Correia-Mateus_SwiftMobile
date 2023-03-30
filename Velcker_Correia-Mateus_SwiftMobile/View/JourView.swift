//
//  JourView.swift
//  Velcker_Correia-Mateus_SwiftMobile
//
//  Created by m1 on 28/03/2023.
//

import SwiftUI

struct JourView: View {
  @EnvironmentObject var authentification: Authentification
  @Environment(\.dismiss) private var dismiss
  
  @ObservedObject var jour: JourViewModel
  var intentJour: JourIntent
  
  /*@State var nom: String
  @State var ouverture: Date
  @State var fermeture: Date*/
  
  init(jour: JourViewModel) {
    self.jour = jour
    self.intentJour = JourIntent(jourVM: jour)
    /*self._nom = State(initialValue: jour.nom)
    self._ouverture = State(initialValue: jour.ouverture)
    self._fermeture = State(initialValue: jour.fermeture)*/

  }
  
  var body: some View {
    VStack(alignment: .leading) {
      //Informations
      VStack(alignment: .center) {
        Text("\(jour.nom)")
        Text("De \(jour.ouverture.toString()) à \(jour.fermeture.toString())")
      }
      
      //Créneaux
      List {
        ForEach(jour.creneauxList) { c in
          VStack(alignment:.leading) {
            Text("De \(c.debut.toString()) à \(c.fin.toString())")
          }
        }
      }
    }.navigationBarBackButtonHidden(true)
    .onAppear {
      Task {
        intentJour.getCreneaux(token: authentification.token)
      }
    }
    
  }
}
