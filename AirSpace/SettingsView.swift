//
//  SettingsView.swift
//  AirSpace
//
//  Created by Roshin Nishad on 9/11/25.
//

import SwiftUI

struct SettingsView: View {
  var body: some View {
    NavigationSplitView {
      List {
        Label("General", systemImage: "gear")
        Label("About", systemImage: "info.circle")
      }.listStyle(.sidebar)
    } detail: {
      Group {
        VStack {
          HStack {
            Text("Welcome to AirSpace.")
              .font(.title2)
              .fontWeight(.bold)
            Spacer()
            Image(systemName: "airplane.departure")
              .font(.system(size: 20))
          }
          Divider()
          Text("A Quick Notice")
            .fontWeight(.semibold)
            .padding(.vertical, 12)
          VStack(alignment: .leading, spacing: 20) {
            Text(
              "AirSpace can only detect and switch to spaces that you first visit using macOS."
            )
            .fixedSize(horizontal: false, vertical: true)
            Text(
              "AirSpace can only detect the removal of a space once you try to visit it."
            )
            .fixedSize(horizontal: false, vertical: true)
            Text(
              "To use AirSpace, you’ll have to go through a quick setup process, by pressing Begin."
            )
            .fixedSize(horizontal: false, vertical: true)
          }
          Button("Begin Setup") {
          }
          .padding(.vertical, 20)
          Divider().padding(.bottom, 8)
        }
        .frame(
          maxWidth: .infinity,
          maxHeight: 400,
          alignment: .topLeading
        )

      }
      .padding(.all, 16)
    }
  }
}
