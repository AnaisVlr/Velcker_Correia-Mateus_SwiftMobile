//
//  Home.swift
//  Velcker_Correia-Mateus_SwiftMobile
//
//  Created by m1 on 18/03/2023.
//

import SwiftUI

struct HomeView: View {
  @EnvironmentObject var authentification: Authentification
  
  @ObservedObject var benevole: BenevoleViewModel
  var intentBenevole: BenevoleIntent
  
  @State var affectations: [Affectation] = []
  @State var creneaux: [Creneau] = []
  @State var festivals: [Festival] = []
  @State var zones: [Zone] = []
  
  init(benevole : BenevoleViewModel) {
    self.benevole = benevole
    self.intentBenevole = BenevoleIntent(benevoleVM: benevole)
  }
  
  var body: some View {
    VStack{
      VStack(alignment: .center) {
        Text("Bonjour \(benevole.prenom) !")
      }
      VStack(){
        if(festivals.filter {$0.is_active}.count > 0) {
          Text("Prochains créneaux :")
        }
        List {
          ForEach(festivals.filter {$0.is_active}) { f in
            Text("\(f.nom)")
            ForEach(zones.filter {$0.id_festival == f.id}) {z in
              ForEach(affectations.filter {$0.id_zone == z.id}) {a in
                ForEach(creneaux.filter {$0.id_creneau == a.id_creneau}) {c in
                  VStack() {
                    Text("- \(z.nom) : De \(c.debut.toString()) à \(c.fin.toString())")
                  }
                }
              }
            }
          }
        }
      }
    }.onAppear {
      Task {
        FestivalService().getAllByBenevoleId(token: authentification.token, id_benevole: benevole.id_benevole) { res in
          switch res {
          case .success(let festivals):
            if(festivals != nil) {
              self.festivals = festivals!
            }
          case .failure(let failure):
              print(failure)
          }
        }
      }
      Task {
        AffectationService().getAllByBenevoleId(token: authentification.token, id_benevole: benevole.id_benevole) { res in
          switch res {
          case .success(let affectations):
            if(affectations != nil) {
              self.affectations = affectations!
            }
          case .failure(let failure):
              print(failure)
          }
        }
      }
      Task {
        ZoneService().getAllByBenevoleId(token: authentification.token, id_benevole: benevole.id_benevole) { res in
          switch res {
          case .success(let zones):
            if(zones != nil) {
              self.zones = zones!
            }
          case .failure(let failure):
              print(failure)
          }
        }
      }
      Task {
        CreneauService().getAllByBenevoleId(token: authentification.token, id_benevole: benevole.id_benevole) { res in
          switch res {
          case .success(let creneaux):
            if(creneaux != nil) {
              self.creneaux = creneaux!
            }
          case .failure(let failure):
              print(failure)
          }
        }
      }
    }
  }
}

