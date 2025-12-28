//
//  OnboardingRootView.swift
//  AirSpace
//
//  Created by Hazel Nishad on 8/9/25.
//

import SwiftUI

enum Content {
  case firstTime, setup, recording
}

struct OnboardingRootView: View {

  @Environment(\.openSettings) private var openSettings

  @State private var curContent: Content = .firstTime

  var body: some View {
    let isSetup = (curContent == .setup)
    let onboardingMenuItems: [MenuItem] = [
      .init(
        title: "Preferences",
        shortcutTitle: "⌘ ,",
        shortcut: KeyEquivalent(","),
        action: {
          openSettings()
          // NSApp means NSApplication.shared
          // Bring settings window to the front after opening.
          NSApp.activate()
        }
      ),
      .init(
        title: "Quit AirSpace",
        shortcutTitle: "⌘ Q",
        shortcut: KeyEquivalent("Q"),
        action: {
          NSApp.terminate(nil)
        }
      ),
    ]

    // ------------ View Returned Below -------------

    VStack {
      HStack {
        if isSetup {
          Button {
            curContent = .firstTime
          } label: {
            Image(systemName: "chevron.backward")
          }
          .transition(.opacity)
          .padding(.trailing, 2)
        }
        Text(
          isSetup
            ? "Setup AirSpace." : "Welcome to AirSpace."
        )
        .font(.title2)
        .fontWeight(.bold)
        .contentTransition(.opacity)
        Spacer()
        Image(systemName: "airplane.departure")
          .font(.system(size: 20))
      }
      Divider()
      Spacer()
      ZStack {
        VStack(spacing: 16) {

          switch curContent {
          case .firstTime:
            OnboardingWelcomeView(curContent: $curContent)
          case .setup:
            OnboardingSetupView(curContent: $curContent)
          case .recording:
            OnboardingRecordingView(curContent: $curContent)
          }

        }
        .padding(.vertical, 16)
      }
      .animation(.easeInOut, value: curContent)
      Spacer()
      Divider()
        .padding(.bottom, 8)
      MenuPanel(items: onboardingMenuItems)
    }
  }
}
