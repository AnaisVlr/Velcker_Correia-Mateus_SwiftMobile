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
  
  var body: some View {
    Button {
      dismiss()
    } label: {
      Text("\(texte)")
    }
  }
}
