//
//  GeneralView.swift
//  AirSpace
//
//  Created by Hazel Nishad on 9/13/25.
//

import LaunchAtLogin
import SwiftUI

struct SettingsGeneralPane: View {

  @EnvironmentObject var appSettings: AppSettings

  var body: some View {
    Form {
      VStack(alignment: .leading, spacing: 16) {
        SettingsToggle(
          settingDescription: "Launch At Login",
          isOn: $appSettings.willLaunchAtLogin,
          onChange: appSettings.willLaunchAtLogin
        ) {
          LaunchAtLogin.isEnabled = appSettings.willLaunchAtLogin
        }
        SettingsToggle(
          settingDescription:
            "Automatically Create Record When Not In Setup Mode",
          isOn: $appSettings.willAutoCreateRecordInNormalMode,
          onChange: appSettings.willAutoCreateRecordInNormalMode,
          doOnChange: {}
        )
      }
      .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
      .padding(.all, 16)
    }
  }
}
