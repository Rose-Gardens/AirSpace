//
//  ContentView.swift
//  AirSpace
//
//  Created by Roshin Nishad on 9/12/25.
//

import SwiftUI

enum Screen: Hashable {
  case onboarding, setup, switcher
}

struct RootView: View {
  @State private var curScreen: Screen = .onboarding
  var body: some View {
    ZStack {
      switch curScreen {
      case .onboarding:
        OnboardingView(openSetup: {curScreen = .setup})
          .transition(.move(edge: .leading))
      case .setup:
        SetupView(openOnboarding: {curScreen = .onboarding})
          .transition(.move(edge: .trailing))
      case .switcher:
        OnboardingView(openSetup: {curScreen = .setup})
          .transition(.move(edge: .trailing))
      }
    }.animation(.easeInOut, value: curScreen)
  }
}
