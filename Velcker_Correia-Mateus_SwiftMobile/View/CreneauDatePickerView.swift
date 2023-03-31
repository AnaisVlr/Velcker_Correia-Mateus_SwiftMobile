//
//  CreneauDatePickerView.swift
//  Velcker_Correia-Mateus_SwiftMobile
//
//  Created by m1 on 31/03/2023.
//

import Foundation
import SwiftUI

struct CreneauDatePickerView: View {
    
  @State var creneau: Creneau
  
  init(creneau: Creneau) {
    self._creneau = State(initialValue: creneau)
  }
  
  var body: some View {
    DatePicker(
      "Début",
      selection: $creneau.debut,
      displayedComponents: [.hourAndMinute]
    )
    DatePicker(
      "Fin",
      selection: $creneau.fin,
      displayedComponents: [.hourAndMinute]
    )
  }
}
