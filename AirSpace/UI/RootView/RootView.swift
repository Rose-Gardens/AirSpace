//
//  ContentView.swift
//  AirSpace
//
//  Created by Hazel Nishad on 9/12/25.
//

import SwiftUI

struct RootView: View {

  @EnvironmentObject private var appDelegate: AppDelegate
  @Environment(\.openSettings) private var openSettings

  var body: some View {

    let rootViewState = appDelegate.rootViewState
    let menuItems = [
      MenuItem(
        title: "Redo Setup...",
        shortcutTitle: "⌘ R",
        shortcut: KeyEquivalent("R"),
        action: {
          // TODO:
          //INSTRUCTIONS:
          // Set AppState to Setup State
        }
      ),
      MenuItem(
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
      MenuItem(
        title: "Quit AirSpace",
        shortcutTitle: "⌘ Q",
        shortcut: KeyEquivalent("Q"),
        action: {
          NSApp.terminate(nil)
        }
      ),
    ]
    VStack {
      ZStack {
        switch rootViewState {
        case .onboarding:
          OnboardingRootView()
        case .switcher:
          OnboardingRootView()
        }
      }
      Spacer()
      Divider()
        .padding(.bottom, 8)
      MenuPanel(items: menuItems)
    }
    .background(Color.teal)
        .padding(.all, 16)
    .animation(.easeInOut, value: rootViewState)
    .environmentObject(AirSpaceMananger.shared)
    .environmentObject(AppSettings.shared)
  }
}
