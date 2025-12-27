//
//  SettingsView.swift
//  AirSpace
//
//  Created by Hazel Nishad on 9/11/25.
//

import SwiftUI

enum Pane: Hashable {
  case general, about
}

struct SettingsRootView: View {

  @State private var curPane: Pane = .general
  @State private var visibility: NavigationSplitViewVisibility = .all

  var body: some View {
    NavigationSplitView(columnVisibility: $visibility) {
      List(selection: $curPane) {
        NavigationLink(value: Pane.general) {
          Label("General", systemImage: "gearshape")
        }
        NavigationLink(value: Pane.about) {
          Label("About", systemImage: "info.circle")
        }
      }
      .listStyle(.sidebar)
      .toolbar(removing: .sidebarToggle)
      .navigationSplitViewColumnWidth(200)
    } detail: {

      switch curPane {
      case .general:
        SettingsGeneralPane()
      case .about:
        SettingsAboutPane()
      }

    }
    .onChange(of: visibility) {
      if visibility != .all { visibility = .all }
    }
    .environmentObject(AppSettings.shared)
  }
}
