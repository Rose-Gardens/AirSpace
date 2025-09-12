//
//  SetupView.swift
//  AirSpace
//
//  Created by Roshin Nishad on 9/12/25.
//

import SwiftUI

struct SetupView: View {

  let openOnboarding: () -> Void
  @Environment(\.openSettings) private var openSettings

  var body: some View {

    let setupMenuItems: [MenuItem] = [
      .init(
        title: "Preferences",
        shortcutTitle: "⌘ ,",
        shortcut: KeyEquivalent(","),
        action: {
          openSettings()
        }
      ),
      .init(
        title: "Quit AirSpace",
        shortcutTitle: "⌘ Q",
        shortcut: KeyEquivalent("Q"),
        action: {
          NSApp.terminate(nil)
        }
      ),
    ]

    Group {
      VStack {
        HStack {
          Button {
            openOnboarding()
          } label: {
            Image(systemName: "chevron.backward")
          }
          .padding(.trailing, 2)
          Text("Setup AirSpace.")
            .font(.title2)
            .fontWeight(.bold)
          Spacer()
          Image(systemName: "airplane.departure")
            .font(.system(size: 20))
        }
        Divider().padding(.bottom, 12)
        VStack(alignment: .leading, spacing: 20) {
          Text(
            "Navigate to the first desktop space (Desktop 1)."
          )
          .fixedSize(horizontal: false, vertical: true)
          Text(
            "Press the Start button to begin the setup."
          )
          .fixedSize(horizontal: false, vertical: true)
          Text(
            "Proceed through each subsequent desktop space in order."
          )
          .fixedSize(horizontal: false, vertical: true)
          Text(
            "Once you have reached the final desktop space, press the Complete button."
          )
          .fixedSize(horizontal: false, vertical: true)
        }
        Button("Start") {

        }
        .padding(.vertical, 20)
        Spacer()
        Divider().padding(.bottom, 8)
        MenuPanel(items: setupMenuItems)
      }
      .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)

    }
    .padding(.all, 16)
  }
}
