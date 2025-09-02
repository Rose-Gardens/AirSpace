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
      VStack(alignment: .leading) {
        HStack {
          Text("Welcome to AirSpace.").font(.title2).fontWeight(.bold)
          Spacer()
          Image(systemName: "airplane.departure")
            .font(.system(size: 20))
        }
        Divider()
      }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
      VStack(alignment: .leading) {
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
      }.frame(maxWidth: .infinity, alignment: .leading)
    }.padding(.all, 16)
  }
}
