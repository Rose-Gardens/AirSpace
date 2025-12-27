//
//  AirSpaceApp.swift
//  AirSpace
//
//  Created by Hazel Nishad on 8/8/25.
//

import AppKit
import SwiftUI

@main
struct AirSpaceApp: App {
  @NSApplicationDelegateAdaptor private var appDelegate: AppDelegate
  
  var body: some Scene {
    #if os(macOS)
      Settings {
        SettingsRootView()
          .frame(width: 600)
      }
    #endif
  }
}
