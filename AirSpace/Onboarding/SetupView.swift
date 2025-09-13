//
//  SetupView.swift
//  AirSpace
//
//  Created by Roshin Nishad on 9/12/25.
//

import SwiftUI

// Child View to OnboardingView
struct SetupView: View {
  var body: some View {

    VStack(alignment: .leading, spacing: 20) {
      Text(
        "Navigate to the first desktop space (Desktop 1)."
      )
      .fixedSize(horizontal: false, vertical: true)
      Text(
        "Press the Start button to begin the setup."
      )
      .fixedSize(horizontal: false, vertical: true)
      Text(
        "Proceed through each subsequent desktop space in order."
      )
      .fixedSize(horizontal: false, vertical: true)
      Text(
        "Once you have reached the final desktop space, press the Complete button."
      )
      .fixedSize(horizontal: false, vertical: true)
    }
    Button("Start") {

    }

  }
}
