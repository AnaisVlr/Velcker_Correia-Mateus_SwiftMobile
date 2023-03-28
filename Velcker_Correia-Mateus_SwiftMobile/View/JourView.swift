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
  
  @State var nom: String
  
  init(jour: JourIntent) {
    self._jour = State(initialValue: jour)
      self._nom = State(initialValue: jour.getNom())
  }
  
  var body: some View {
    VStack(alignment: .leading) {
      
      if(authentification.is_admin) {
        Button("Supprimer") {
          Task {
            /*FestivalService().delete(token: authentification.token, id_festival: festival.getId()) {res in
              switch res {
              case .success(let boolean):
                DispatchQueue.main.async {
                  self.dismiss()
                }
              case .failure(let error):
                print(error)
              }
            }*/
          }
        }
      }
    }.navigationBarBackButtonHidden(true)
  }
}
