//
//  AddJourView.swift
//  Velcker_Correia-Mateus_SwiftMobile
//
//  Created by m1 on 29/03/2023.
//

import SwiftUI

struct AddJourView : View {
  @EnvironmentObject var authentification: Authentification
  @Environment(\.dismiss) private var dismiss
  
  @State var jourVM: JourViewModel
  @State var nom: String
  @State var ouverture: Date
  @State var fermeture: Date
    
  let liste: JourListViewModel
  let festival: FestivalViewModel
  @State var creneaux: [Creneau]
  
  init(festival: FestivalViewModel, liste: JourListViewModel?, jour: JourViewModel?) {
    self.festival = festival
    var temp: [Creneau] = []
    
    
    if(liste == nil) {
      self.liste = JourListViewModel()
    }
    else {
      self.liste = liste!
    }
    if(jour == nil) {
      self._jourVM = State(initialValue: JourViewModel(model: Jour(id: -1, id_festival: festival.id_festival, nom: "NomJour", ouverture: Date.now, fermeture: Date.now)))
      temp.append(Creneau(id: -1, id_jour: -1, debut: Date.now, fin: Date.now))
    }
    else {
      self._jourVM = State(initialValue: jour!)
      temp = jour!.creneauxList
      if(temp.count == 0) {
        temp.append(Creneau(id: -1, id_jour: jour!.id_jour, debut: jour!.ouverture, fin: jour!.fermeture))
      }
    }
    self._nom = State(initialValue: "JourNom")
    self._ouverture = State(initialValue: Date.now)
    self._fermeture = State(initialValue: Date.now)
    
    self._creneaux = State(initialValue:temp)
  }

  var body: some View {
    NavigationView {
      VStack(alignment: .center) {
        Text("Informations du nouveau jour")
        VStack() {
          TextField("", text: $nom)
          DatePicker(
            "Ouverture",
            selection: $ouverture,
            displayedComponents: [.hourAndMinute]
          )
          DatePicker(
            "Fermeture",
            selection: $fermeture,
            displayedComponents: [.hourAndMinute]
          )
        }
        
        //Créneaux
        Text("Créneaux")
        List {
          ForEach($creneaux) { c in
            VStack {
              HStack {
                CreneauDatePickerView(creneau: c.wrappedValue)
              }
              
            }
          }
        }
        Button("Ajouter un créneau") {
          let newC = Creneau(id: -1, id_jour: jourVM.id_jour, debut: creneaux.last!.fin, fin: jourVM.ouverture)
          creneaux.append(newC)
        }
        
        //Pour savoir si on vient de la page de création de festival, ou si on ajoute un nouveau jour
        if(festival.id_festival > -1) {
          Button("Créer") {
            let j: Jour = Jour(id: -1, id_festival: self.festival.id_festival, nom: nom, ouverture: ouverture, fermeture: fermeture)
            JourService().create(token: authentification.token, jour: j, creneaux:self.creneaux) { res in
              switch res {
              case .success(let jour):
                self.liste.appendJour(jour)//Pas nécessaire car le onAppear de la listeView refetch
                DispatchQueue.main.async {
                  self.dismiss()
                }
              case .failure(let error):
                print(error)
              }
            }
          }
        }
        else {
          Button("Ok") {
            //TODO faire la vérification des créneaux
            DispatchQueue.main.async {
              self.jourVM.setNom(self.nom)
              self.jourVM.setOuverture(self.ouverture)
              self.jourVM.setFermeture(self.fermeture)
              self.jourVM.setCreneaux(self.creneaux)
              self.dismiss()
            }
          }
        }
        
      }
    }.navigationBarBackButtonHidden(true)
  }
}
