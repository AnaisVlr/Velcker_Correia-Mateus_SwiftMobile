//
//  FestivalView.swift
//  Velcker_Correia-Mateus_SwiftMobile
//
//  Created by m1 on 21/03/2023.
//

import SwiftUI

struct FestivalView: View {
    @State var festival: FestivalViewModel
    @Environment(\.dismiss) private var dismiss
    
    @State var nom: String
    
    init(festival: FestivalViewModel) {
        self._festival = State(initialValue: festival)
        self._nom = State(initialValue: festival.nom)
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            TextField("", text: $nom)
        }.navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: NavBackButton(dismiss: self.dismiss, texte: "Retourner à la liste"))
    }
}
