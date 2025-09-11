//
//  AirSpaceApp.swift
//  AirSpace
//
//  Created by Roshin Nishad on 8/8/25.
//

import SwiftUI

@main
struct AirSpaceApp: App {
  var body: some Scene {
    MenuBarExtra {
      OnboardingView().frame(width: 350)
    } label: {
      Label("Desktop 1", systemImage: "").labelStyle(.titleOnly)
    }.menuBarExtraStyle(.window)

    #if os(macOS)
      Settings {
        SettingsView()
          .frame(minWidth: 200, maxWidth: 800, minHeight: 400, maxHeight: 1000)
      }
    #endif
  }
}
