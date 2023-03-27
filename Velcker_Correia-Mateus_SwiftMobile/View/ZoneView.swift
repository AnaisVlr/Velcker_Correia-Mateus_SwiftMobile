//
//  ZoneView.swift
//  Velcker_Correia-Mateus_SwiftMobile
//
//  Created by Pain des bites on 23/03/2023.
//

import SwiftUI

struct ZoneView: View {
  @State var zone: ZoneIntent
  @EnvironmentObject var authentification: Authentification
  @Environment(\.dismiss) private var dismiss
  
  @State var nom: String
  @State var nb_benevole : Int
  @State var nb_benevole_present : Int
  
  init(zone: ZoneIntent) {
    self._zone = State(initialValue: zone)
    self._nom = State(initialValue: zone.getNom())
    self._nb_benevole = State(initialValue: zone.getNbrBenevole())
    self._nb_benevole_present = State(initialValue: 0)
  }
  
  func getNbrBenevolePresent(benevoles : [Benevole]?) -> Int{
    var nbr : Int = 0
    var benevolesD : [Benevole] = []
    var cpt1 : Int = 0
    var cpt2: Int = 0
    
    if benevoles != nil {
      nbr = benevoles!.count
      benevolesD = benevoles!
      print(benevolesD.count)
      if benevolesD.count != 1 {
        cpt2 = 1
        while cpt1 < benevolesD.count{
          while cpt2 < benevolesD.count{
            if benevolesD[cpt1].email == benevolesD[cpt2].email{
              nbr -= 1
              benevolesD.remove(at: cpt2)
            }else{
              cpt2 += 1
            }
            cpt1 += 1
          }
        }
      }
    }
    return nbr
  }
  
  func isComplete(nb_benevole_present : Int, nb_benevole_necessaire : Int) -> Bool{
    print(nb_benevole_present >= nb_benevole_necessaire)
    return nb_benevole_present >= nb_benevole_necessaire
  }
  
  var body: some View {
    VStack(alignment: .leading) {
      TextField("", text: $nom)
      Picker("Benevole", selection: $nb_benevole) {
        ForEach((1...10).reversed(), id: \.self) {
          Text(verbatim: "\($0)").tag($0)
        }
      }
      if isComplete(nb_benevole_present: self.nb_benevole_present, nb_benevole_necessaire: self.nb_benevole){
        Text("Il y a assez de bénévole dans cette zone")
      }else{
        Text("Il n'y a pas assez de bénévole pour cette zone !")
      }
      Button("Supprimer cette zone") {
        Task {
          ZoneService().delete(token: authentification.token, id_zone: zone.getId()) {res in
            DispatchQueue.main.async {
              self.dismiss()
            }
          }
        }
      }
      Text("Attention la suppression de la zone entrainera une suppression de toutes les affections pour cette zone.")
    }.navigationBarBackButtonHidden(true)
      .onAppear{
        Task{
          ZoneService().getAllBenevoleByZone(token:authentification.token, id_zone: zone.getId()){
            res in
            switch res{
            case .success(let benevoles):
              self.nb_benevole_present = getNbrBenevolePresent(benevoles: benevoles)
              print(nb_benevole_present)
            case .failure(let error):
              print(error)
            }
          }
        }
      }
  }
}
