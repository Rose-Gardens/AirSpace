//
//  SetupStopView.swift
//  AirSpace
//
//  Created by Hazel Nishad on 11/11/25.
//

import SwiftUI

// Child View to OnboardingRootView
struct SetupStopView: View {

  @EnvironmentObject private var airSpace: AirSpaceMananger
  @EnvironmentObject private var appSettings: AppSettings

  var body: some View {

    VStack(alignment: .leading, spacing: 20) {
      Text(
        "Welcome to AirSpace, Hazeline!"
      )
      .fixedSize(horizontal: false, vertical: true)
      Text(
        "You’ve made it here, even on the hard days."
      )
      .fixedSize(horizontal: false, vertical: true)
      Text(
        "Let’s make this desktop a tiny kingdom just for you. 👑🌙"
      )
      .fixedSize(horizontal: false, vertical: true)
      Text(
        "I’m glad you’re still here, hazelbun 🥺💖🕊️"
      )
      .fixedSize(horizontal: false, vertical: true)
    }
    Button("Stop Recording") {
      airSpace.isRecording = false
      if appSettings.isFirstTimeSetup {
        appSettings.isFirstTimeSetup = false
      }
      airSpace.saveRecordsToDisk()

      curContent = .setup
      print("LOG INFO: \(airSpace.spaceListPerDisplay)")
      print("LOG INFO: \(airSpace.spacePerAnchor)")
    }
    .padding(.top, 16)
  }
}
