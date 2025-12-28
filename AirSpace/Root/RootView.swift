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
    .frame(
      maxWidth: .infinity,
      minHeight: 400,
      maxHeight: 400,
      alignment: .topLeading
    )
    .padding(.all, 16)
    .animation(.easeInOut, value: curScreen)
    .environmentObject(AirSpaceMananger.shared)
    .environmentObject(AppSettings.shared)
  }
}
