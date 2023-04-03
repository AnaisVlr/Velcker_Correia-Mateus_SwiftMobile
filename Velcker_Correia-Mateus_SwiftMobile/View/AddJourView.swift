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
  
  @State var erreur: String
    
  let liste: JourListViewModel
  let festival: FestivalViewModel
  @State var creneaux: [Creneau]
  
  init(festival: FestivalViewModel, liste: JourListViewModel?, jour: JourViewModel?) {
    self.festival = festival
    var temp: [Creneau] = []
    self._erreur = State(initialValue: "")
    
    
    if(liste == nil) {
      self.liste = JourListViewModel()
    }
    else {
      self.liste = liste!
    }
    if(jour == nil) {
      self._jourVM = State(initialValue: JourViewModel(model: Jour(id: -1, id_festival: festival.id_festival, nom: "NomJour", ouverture: Date.now, fermeture: Date.now)))
      temp.append(Creneau(id: -1, id_jour: -1, debut: Date.now, fin: Date.now))
      self._nom = State(initialValue: "JourNom")
      self._ouverture = State(initialValue: Date.now)
      self._fermeture = State(initialValue: Date.now)
    }
    else {
      self._jourVM = State(initialValue: jour!)
      temp = jour!.creneauxList
      if(temp.count == 0) {
        temp.append(Creneau(id: -1, id_jour: jour!.id_jour, debut: jour!.ouverture, fin: jour!.fermeture))
      }
      self._nom = State(initialValue: jour!.nom)
      self._ouverture = State(initialValue: jour!.ouverture)
      self._fermeture = State(initialValue: jour!.fermeture)
      
    }
    
    self._creneaux = State(initialValue:temp)
  }
  
  func valid() -> Bool {
    let ho = Calendar.current.dateComponents([.hour], from: ouverture)
    let hf = Calendar.current.dateComponents([.hour], from: fermeture)
    
    if(abs(hf.hour!-ho.hour!) < 2) {
      self.erreur = "Une journée doit durer au moins 2 heures"
      return false
    }
    
    let liste = creneaux.sorted(by: { $0.debut < $1.debut})
    if(liste.count < 1) {
      self.erreur = "Il doit y avoir au moins un créneau"
      return false
    }
    
    if(liste.first!.debut.toString() != ouverture.toString() || liste.last!.fin.toString() != fermeture.toString()) {
      self.erreur = "Les créneaux doivent remplir la plage horaire"
      return false
    }
    //Si les créneaux font au moins 2 heures
    for c in liste {
      let ho = Calendar.current.dateComponents([.hour], from: c.debut)
      let hf = Calendar.current.dateComponents([.hour], from: c.fin)
      if(abs(hf.hour! - ho.hour!) < 2) {
        self.erreur = "Les créneaux doivent duréer au moins 2 heures"
        return false
      }
    }
    
    var prec = liste.first!
    //Si les créneaux se suivent
    for i in 1..<liste.count {
      if(prec.fin.toString() != liste[i].debut.toString()) {
        self.erreur = "Les créneaux doivent remplir la plage horaire"
        return false
      }
      prec = liste[i]
    }
    
    return true
  }

  var body: some View {
    HStack(alignment: .top) {
      NavigationView(){
        VStack(alignment :.leading){
          Button(action: {
            self.dismiss()
          }) {
            HStack{
              Spacer().frame(width : 15)
              Image(systemName: "arrowshape.turn.up.backward.fill")
              Text("Retour à la liste des jours")
            }
          }
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
              }.onDelete { offset in
                creneaux.remove(atOffsets: offset)
              }
            }
            
            HStack(alignment: .bottom) {
              Button("Ajouter un créneau") {
                let newC = Creneau(id: -1, id_jour: jourVM.id_jour, debut: creneaux.last!.fin, fin: jourVM.ouverture)
                creneaux.append(newC)
              }.buttonStyle(CustomButton())
              Text(erreur)
              
              //Pour savoir si on vient de la page de création de festival, ou si on ajoute un nouveau jour
              if(festival.id_festival > -1) {
                Button("Créer") {
                  if(valid()) {
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
                }.buttonStyle(CustomButton())
              }
              else {
                HStack() {
                  Button("Annuler") {
                    DispatchQueue.main.async {
                      self.dismiss()
                    }
                  }.buttonStyle(CustomButton())
                  Button("Ok") {
                    //TODO faire la vérification des créneaux
                    if(valid()) {
                      DispatchQueue.main.async {
                        self.jourVM.setNom(self.nom)
                        self.jourVM.setOuverture(self.ouverture)
                        self.jourVM.setFermeture(self.fermeture)
                        self.jourVM.setCreneaux(self.creneaux)
                        self.dismiss()
                      }
                    }
                  }.buttonStyle(CustomButton())
                }
              }
            }
          }
        }
      }
    }
  }
}
