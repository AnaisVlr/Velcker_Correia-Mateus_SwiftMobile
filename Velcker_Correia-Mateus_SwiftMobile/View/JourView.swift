//
//  JourView.swift
//  Velcker_Correia-Mateus_SwiftMobile
//
//  Created by m1 on 28/03/2023.
//

import SwiftUI

struct JourView: View {
  @State var jour: JourIntent
  @EnvironmentObject var authentification: Authentification
  @Environment(\.dismiss) private var dismiss
  
  
  let festival: FestivalIntent
  @State var nom: String
  @State var ouverture: Date
  @State var fermeture: Date
  @State var creneaux: [Creneau] = []
  
  init(jour: JourIntent, festival: FestivalIntent) {
    self._jour = State(initialValue: jour)
    self._nom = State(initialValue: jour.getNom())
    self._ouverture = State(initialValue: jour.getOuverture())
    self._fermeture = State(initialValue: jour.getOuverture())
    self.festival = festival
  }
  
  var body: some View {
    VStack(alignment: .leading) {
      //Informations
      VStack(alignment: .center) {
        Text("\(nom)")
        Text("De \(ouverture.toString()) à \(fermeture.toString())")
        if(authentification.is_admin) {
          Button("Supprimer") {
            Task {
              JourService().delete(token: authentification.token, id_jour: jour.getId()) {res in
                switch res {
                case .success(_ ):
                  DispatchQueue.main.async {
                    self.dismiss()
                  }
                case .failure(let error):
                  print(error)
                }
              }
            }
          }.disabled(self.festival.getNbJour() <= 1)
        }
      }
      
      //Créneaux
      List(self.creneaux) { c in
        VStack(alignment:.leading) {
          Text("De \(c.debut.toString()) à \(c.fin.toString())")
        }
      }
    }.navigationBarBackButtonHidden(true)
      .onAppear {
        Task {
          CreneauService().getAllByJourId(token: authentification.token, id_jour: self.jour.getId()) {res in
          switch res {
          case .success(let creneaux):
            self.creneaux = creneaux!
          case .failure(let error):
            print(error)
          }
        }
      }
    }
  }
}
