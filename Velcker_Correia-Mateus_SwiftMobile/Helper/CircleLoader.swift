//
//  CircleLoader.swift
//  SwiftUI-Animations
//
//
//
//

import SwiftUI

struct CircleLoader: View {
    
  @State private var rotateDegrees: Double = 0.0
  var body: some View {
    Circle()
      .trim(from: 0.1, to: 1)
      .stroke(
        LinearGradient(gradient: Gradient(colors: [Color.red, Color.blue]), startPoint: .topTrailing, endPoint: .bottomLeading), style: StrokeStyle(lineWidth: 5, lineCap: .round, lineJoin: .round, miterLimit: .infinity, dash: [20, 0], dashPhase: 0)
      )
      .rotationEffect(Angle(degrees: rotateDegrees))
      .rotation3DEffect(Angle(degrees: 180), axis: (x: 1, y: 0, z:0))
      .frame(width: 44, height: 44, alignment: .center)
      .shadow(color: Color.blue.opacity(0.1), radius: 3, x: 0, y: 3)
      .onAppear {
        withAnimation(Animation.linear(duration: 3).repeatForever(autoreverses: false)) {
          self.rotateDegrees = 360
        }
      }
  }
}
