//
//  ContentView.swift
//  AirSpace
//
//  Created by Roshin Nishad on 8/9/25.
//

import SwiftUI

struct ContentView: View {
  var body: some View {
    Group {
      VStack {
        HStack {
          Text("Welcome to AirSpace.").font(.title2).fontWeight(.bold)
          Spacer()
          Image(systemName: "airplane.departure")
            .font(.system(size: 20))
        }
        Divider()
        Text("A Quick Notice").fontWeight(.semibold).padding(.vertical, 12)
        VStack(alignment: .leading, spacing: 20) {
          Text(
            "AirSpace can only detect and switch to spaces that you first visit using macOS."
          ).fixedSize(horizontal: false, vertical: true)
          Text(
            "AirSpace can only detect the removal of a space once you try to visit it."
          ).fixedSize(horizontal: false, vertical: true)
          Text(
            "To use AirSpace, you’ll have to go through a quick setup process, by pressing Begin."
          ).fixedSize(horizontal: false, vertical: true)
        }
        Button("Begin Setup") {}.padding(.vertical, 20)
        Spacer()
        Divider().padding(.bottom, 8)
      }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
      VStack(spacing: 8) {
        Button {

        } label: {
          Label("Preferences", systemImage: "").labelStyle(.titleOnly)
          Spacer()
          Label("⌘ ,", systemImage: "")
            .labelStyle(.titleOnly)
            .foregroundStyle(.tertiary)
        }
        .buttonStyle(.plain).keyboardShortcut("q")
        Button {
          NSApp.terminate(nil)
        } label: {
          Label("Quit AirSpace", systemImage: "").labelStyle(.titleOnly)
          Spacer()
          Label("⌘ Q", systemImage: "")
            .labelStyle(.titleOnly)
            .foregroundStyle(.tertiary)
        }
        .buttonStyle(.plain).keyboardShortcut("q")
      }
    }.padding(.all, 16)
  }
}
