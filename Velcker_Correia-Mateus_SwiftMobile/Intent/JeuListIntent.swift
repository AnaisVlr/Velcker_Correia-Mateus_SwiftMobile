//
//  JeuListIntent.swift
//  Velcker_Correia-Mateus_SwiftMobile
//
//  Created by m1 on 01/04/2023.
//

import SwiftUI

enum JeuListState {
  case ready
  case loading
  case deleting
  case errorLoading
  case errorDeleting
}

struct JeuListIntent {
  var jeuListVM: JeuListViewModel
  
    func getJeuList(token: String, id_festival: Int) {
    jeuListVM.setState(.loading)
    
    JeuService().getAllByFestivalId(token: token, id_festival: id_festival) {res in
      switch res {
      case .success(let jeux):
        jeuListVM.setJeux(jeux!.sorted(by: { $0.id > $1.id}))
        jeuListVM.setState(.ready)
        
      case .failure(_ ):
        jeuListVM.setState(.errorLoading)
      }
    }
  }
  func delete(token: String, index: Int) {
    jeuListVM.setState(.deleting)
    
    let jeu = jeuListVM.jeuList[index]
    JeuService().delete(token: token, id_jeu: jeu.id_jeu) {res in
      switch res {
      case .success(_ ):
        jeuListVM.jeuList.remove(at: index)
        jeuListVM.setState(.ready)
        
      case .failure(let error):
        print(error)
        jeuListVM.setState(.errorDeleting)
      }
    }
  }
}
