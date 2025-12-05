//
//  OnboardingRecordingView.swift
//  AirSpace
//
//  Created by Roshin Nishad on 11/11/25.
//

import SwiftUI

// Child View to OnboardingRootView
struct OnboardingRecordingView: View {
  @Binding var curContent: Content

  @EnvironmentObject var airSpace: AirSpaceMananger

  var body: some View {

    VStack(alignment: .leading, spacing: 20) {
      Text(
        "Congrats."
      )
      .fixedSize(horizontal: false, vertical: true)
      Text(
        "Your blood shall be spilt upon this wretched land."
      )
      .fixedSize(horizontal: false, vertical: true)
      Text(
        "You think of yourself as so precious?"
      )
      .fixedSize(horizontal: false, vertical: true)
      Text(
        "May your wicked flesh burn as the others had."
      )
      .fixedSize(horizontal: false, vertical: true)
    }
    Button("Stop Recording") {
      airSpace.isRecordingSetup = false
      curContent = .setup
      print(airSpace.spaceListPerDisplay)
    }
    .padding(.top, 16)
  }
}
