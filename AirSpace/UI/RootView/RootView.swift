//
//  ContentView.swift
//  AirSpace
//
//  Created by Hazel Nishad on 9/12/25.
//

import SwiftUI

struct RootView: View {

  @EnvironmentObject private var appState: AppState
  @Environment(\.openSettings) private var openSettings

  var body: some View {
    let menuItems = [
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
        appState.getRootContentView()
      }
      Spacer()
      Divider()
        .padding(.bottom, 8)
      MenuPanel(items: menuItems)
    }
    // TODO: Test this out
    .frame(
      maxWidth: .infinity,
      minHeight: 440,
      maxHeight: 1200,
      alignment: .topLeading
    )
    .padding(.all, 16)
    .environmentObject(AirSpaceMananger.shared)
    .environmentObject(AppSettings.shared)
  }
}
