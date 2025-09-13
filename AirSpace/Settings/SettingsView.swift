//
//  SettingsView.swift
//  AirSpace
//
//  Created by Roshin Nishad on 9/11/25.
//

import SwiftUI

enum Tabs: Hashable {
  case general, about
}

struct SettingsView: View {

  @State private var curTab: Tabs = .general
  @State private var visibility: NavigationSplitViewVisibility = .all
  @State private var isOn = UserDefaults.standard.bool(forKey: "login")

  var body: some View {
    NavigationSplitView(columnVisibility: $visibility) {
      List(selection: $curTab) {
        NavigationLink(value: Tabs.general) {
          Label("General", systemImage: "gearshape")
        }
        NavigationLink(value: Tabs.about) {
          Label("About", systemImage: "info.circle")
        }
      }
      .listStyle(.sidebar)
      .toolbar(removing: .sidebarToggle)
      .navigationSplitViewColumnWidth(200)
    } detail: {

      switch curTab {
      case .general:
        GeneralView(isOn: $isOn)
      case .about:
        AboutView()
      }

    }
    .onChange(of: visibility) { oldState, newState in
      if newState != .all { visibility = .all }
    }
  }
}
