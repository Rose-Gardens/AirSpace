//
//  SettingsToggle.swift
//  AirSpace
//
//  Created by Hazel Nishad on 12/25/25.
//

import SwiftUI

struct SettingsToggle: View {
  
  let settingDescription: String
  let isOn: Binding<Bool>
  let onChange: Bool
  let doOnChange: () -> Void

  var body: some View {
    // TODO: Add subtext to toggle text
    HStack {
      Text(settingDescription)
      Spacer()
      Toggle("", isOn: isOn)
        .toggleStyle(.switch)
        .labelsHidden()
        .onChange(of: onChange, initial: true) {
          doOnChange()
        }
    }
  }
}
