//
//  ContentView.swift
//  AirSpace
//
//  Created by Hazel Nishad on 9/12/25.
//

import SwiftUI

struct RootView: View {

  @EnvironmentObject private var appDelegate: AppDelegate

  var body: some View {

    let curScreen = appDelegate.rootViewState

    ZStack {
      switch curScreen {
      case .onboarding:
        OnboardingRootView()
      case .switcher:
        OnboardingRootView()
      case .repairAnchor:
        RepairAnchor()
      }
    }
    .animation(.easeInOut, value: curScreen)
    .environmentObject(AirSpaceMananger.shared)
    .environmentObject(AppSettings.shared)
  }
}
