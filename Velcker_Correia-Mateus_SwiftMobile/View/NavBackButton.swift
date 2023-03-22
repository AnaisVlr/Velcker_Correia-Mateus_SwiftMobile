//
//  NavBackButton.swift
//  Velcker_Correia-Mateus_SwiftMobile
//
//  Created by m1 on 21/03/2023.
//

import SwiftUI

struct NavBackButton: View {
  let dismiss: DismissAction
  let texte: String
  
  func goBack() {
    dismiss()
  }
  
  var body: some View {
    Button(action: goBack) {
      HStack() {
        Image(systemName: "chevron.left")
        Text("\(texte)")
      }
      
    }
  }
}
