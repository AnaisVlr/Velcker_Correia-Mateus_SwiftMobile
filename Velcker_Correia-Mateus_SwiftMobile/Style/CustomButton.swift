//
//  Style.swift
//  Velcker_Correia-Mateus_SwiftMobile
//
//  Created by m1 on 02/04/2023.
//

import SwiftUI

struct CustomButton: ButtonStyle {
  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .padding()
      .border(Color("AccentColor"))
      .cornerRadius(10)
      .overlay(
             RoundedRectangle(cornerRadius: 10)
                 .stroke(Color("AccentColor"), lineWidth: 2)
         )
  }
}
