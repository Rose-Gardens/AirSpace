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
      ContentView().frame(width: 350)
    } label: {
      Label("Desktop 1", systemImage: "").labelStyle(.titleOnly)
    }.menuBarExtraStyle(.window)
    
    #if os(macOS)
      Settings {
        ContentView()
      }
    #endif
  }
}
