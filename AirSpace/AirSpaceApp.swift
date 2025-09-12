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
      RootView()
        .frame(width: 350)
    } label: {
      Text("Desktop 1")
    }.menuBarExtraStyle(.window)

    #if os(macOS)
      Settings {
        SettingsView()
          .frame(width: 400)
          .background(.thinMaterial)
      }
    #endif
  }
}
