//
//  GeneralView.swift
//  AirSpace
//
//  Created by Roshin Nishad on 9/13/25.
//

import SwiftUI
import LaunchAtLogin

struct SettingsGeneralPane: View {
  
  @Binding var isOn: Bool
  
    var body: some View {
      Form {
        VStack(alignment: .leading, spacing: 16) {
          HStack {
            Text("Launch at login")
            Spacer()
            Toggle("", isOn: $isOn)
              .toggleStyle(.switch)
              .labelsHidden()
              .onChange(of: isOn, initial: true) {
                LaunchAtLogin.isEnabled = isOn
                UserDefaults.standard.set(isOn, forKey: "login")
              }
          }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .padding(.all, 16)
      }
    }
}
