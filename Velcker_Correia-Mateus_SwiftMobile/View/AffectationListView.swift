//
//  AffectationListView.swift
//  Velcker_Correia-Mateus_SwiftMobile
//
//  Created by m1 on 27/03/2023.
//

import SwiftUI

struct AffectationListView: View {
  @EnvironmentObject var authentification: Authentification
  @Environment(\.dismiss) private var dismiss
  var festival: Festival
  @State var affectationList: [Affectation]
  @State var jourList: [Jour]
    
  var body: some View {
    VStack(alignment: .center) {
        
    }.onAppear {
      Task {
        AffectationService().getAllByFestivalIdAndBenevoleId(token: authentification.token, id_festival: festival.id, id_benevole: authentification.id) {res in
          switch res {
          case .success(let affectations):
            self.affectationList = affectations!
          case .failure(let error):
            print(error)
          }
        }
        JourService().getAllByFestivalId(token: authentification.token, id_festival: festival.id) {res in
          switch res {
          case .success(let jours):
            self.jourList = jours!
          case .failure(let error):
            print(error)
          }
        }
      }
    }
              
  }
}
