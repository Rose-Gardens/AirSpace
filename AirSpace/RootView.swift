//
//  ContentView.swift
//  AirSpace
//
//  Created by Roshin Nishad on 9/12/25.
//

import SwiftUI

enum Screen: Hashable {
  case onboarding, switcher
}

struct RootView: View {
  @State private var curScreen: Screen = .onboarding
  var body: some View {
    ZStack {
      switch curScreen {
      case .onboarding:
        OnboardingView()
          .transition(.move(edge: .leading))
      case .switcher:
        OnboardingView()
          .transition(.move(edge: .trailing))
      }
    }.animation(.easeInOut, value: curScreen)
  }
}
