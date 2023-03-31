//
//  FestivalListView.swift
//  Velcker_Correia-Mateus_SwiftMobile
//
//  Created by m1 on 19/03/2023.
//

import SwiftUI

struct FestivalListView: View {
  @EnvironmentObject var authentification: Authentification
  @Environment(\.dismiss) private var dismiss
  
  @ObservedObject var festivalList: FestivalListViewModel
  var intentListFestival: FestivalListIntent
  
  init() {
    let fl = FestivalListViewModel()
    self.festivalList = fl
    self.intentListFestival = FestivalListIntent(festivalListVM: fl)
  }
  
  var body: some View {
    NavigationView {
      VStack(alignment: .center) {
        switch self.festivalList.state {
        case .loading:
          Text("")
        case .deleting:
          Text("")
        case .ready:
          Text("Prêt")
        case .errorLoading:
          Text("Erreur Chargement")
        case .errorDeleting:
          Text("Erreur Suppression")
        }
        
        Text("Liste des festivals")
        if(authentification.is_admin) {
          NavigationLink("Ajouter un festival") {
            AddFestivalView(liste: festivalList)
          }
        }
        
        List {
          ForEach(festivalList.festivalList) { f in
            VStack(alignment:.leading) {
              let str = f.is_active ? f.nom : "(Clôturé) \(f.nom)"
              NavigationLink(str) {
                FestivalView(festival: f)
              }
              Text("Sur \(f.nombre_jour) jour(s)")
            }
          }.onDelete { indexSet in
            for i in indexSet { //Pour récupérer l'objet supprimé
              Task {
                self.intentListFestival.delete(token: authentification.token, index: i)
              }
            }
          }.deleteDisabled(!authentification.is_admin)
        }
        
      }.padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
        .onAppear {
          Task {
            intentListFestival.getFestivalList(token: authentification.token)
          }
        }
    }.navigationBarBackButtonHidden(true)
      .navigationBarItems(leading: NavBackButton(dismiss: self.dismiss, texte: "Accueil"))
    
  }
}
