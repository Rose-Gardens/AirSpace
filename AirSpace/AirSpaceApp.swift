//
//  AirSpaceApp.swift
//  AirSpace
//
//  Created by Roshin Nishad on 8/8/25.
//

import SwiftUI
import AppKit

@main
struct AirSpaceApp: App {
  var body: some Scene {
    
    @NSApplicationDelegateAdaptor(AppDelegate.self) var AppDelegate
    #if os(macOS)
      Settings {
        SettingsRootView()
          .frame(width: 600)
      }
    #endif
  }
}
