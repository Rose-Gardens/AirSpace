//
//  AppSettings.swift
//  AirSpace
//
//  Created by Hazel Nishad on 12/8/25.
//

import Foundation

@MainActor
final class AppSettings: ObservableObject {

  // The singleton shared object ----
  static let shared = AppSettings(
    willLaunchAtLogin: UserDefaults.standard.bool(
      forKey: "willLaunchAtLogin"
    ),
    isFirstTimeSetup: UserDefaults.standard.bool(
      forKey: "isFirstTimeSetup"
    ),
    willAutoCreateRecordInNormalMode: UserDefaults.standard.bool(
      forKey: "willAutoCreateRecordInNormalMode"
    ),
    wontShowRestartNoticeAgain: UserDefaults.standard.bool(
      forKey: "wontShowRestartNoticeAgain"
    ),
    userHasMadeOnRestartChoice: UserDefaults.standard.bool(
      forKey: "userHasMadeOnRestartChoice"
    ),
    willKeepNamesOnRestart: UserDefaults.standard.bool(
      forKey: "willKeepNamesOnRestart"
    ),
  )

  // The properties of the class ----
  @Published var willLaunchAtLogin: Bool {
    didSet {
      UserDefaults.standard.set(willLaunchAtLogin, forKey: "willLaunchAtLogin")
    }
  }
  @Published var isFirstTimeSetup: Bool {
    didSet {
      UserDefaults.standard.set(isFirstTimeSetup, forKey: "isFirstTimeSetup")
    }
  }
  @Published var willAutoCreateRecordInNormalMode: Bool {
    didSet {
      UserDefaults.standard.set(
        willAutoCreateRecordInNormalMode,
        forKey: "willAutoCreateRecordInNormalMode"
      )
    }
  }
  @Published var wontShowRestartNoticeAgain: Bool {
    didSet {
      UserDefaults.standard.set(
        wontShowRestartNoticeAgain,
        forKey: "wontShowRestartNoticeAgain"
      )
    }
  }
  @Published var userHasMadeOnRestartChoice: Bool {
    didSet {
      UserDefaults.standard.set(
        userHasMadeOnRestartChoice,
        forKey: "userHasMadeOnRestartChoice"
      )
    }
  }
  @Published var willKeepNamesOnRestart: Bool {
    didSet {
      UserDefaults.standard.set(
        willKeepNamesOnRestart,
        forKey: "willKeepNamesOnRestart"
      )
    }
  }

  // The constructor of the class (accessed only by 'shared') ----
  private init(
    willLaunchAtLogin: Bool,
    isFirstTimeSetup: Bool,
    willAutoCreateRecordInNormalMode: Bool,
    wontShowRestartNoticeAgain: Bool,
    userHasMadeOnRestartChoice: Bool,
    willKeepNamesOnRestart: Bool,
  ) {
    self.willLaunchAtLogin = willLaunchAtLogin
    self.isFirstTimeSetup = isFirstTimeSetup
    self.willAutoCreateRecordInNormalMode = willAutoCreateRecordInNormalMode
    self.wontShowRestartNoticeAgain = wontShowRestartNoticeAgain
    self.userHasMadeOnRestartChoice = userHasMadeOnRestartChoice
    self.willKeepNamesOnRestart = willKeepNamesOnRestart
  }

  // --------------- *Methods of AppSettings* ----------------

  func registerUserDefaults() {
    let defaultSettings = [
      "isFirstTimeSetup": "true",
      "willLaunchAtLogin": "false",
      "willAutoCreateRecordInNormalMode": "false",
      "wontShowRestartNoticeAgain": "false",
      "userHasMadeOnRestartChoice": "false",
      "willKeepNamesOnRestart": "true",
    ]
    UserDefaults.standard.register(defaults: defaultSettings)
    let nc = NotificationCenter.default
    nc
      .addObserver(
        self,
        selector: #selector(loadSettings),
        name: NSNotification.Name("SettingsChanged"),
        object: nil
      )
  }

  @objc func loadSettings() {
    self.willLaunchAtLogin = UserDefaults.standard.bool(
      forKey: "willLaunchAtLogin"
    )
    self.isFirstTimeSetup = UserDefaults.standard.bool(
      forKey: "isFirstTimeSetup"
    )
    self.willAutoCreateRecordInNormalMode = UserDefaults.standard.bool(
      forKey: "willAutoCreateRecordInNormalMode"
    )
    self.wontShowRestartNoticeAgain = UserDefaults.standard.bool(
      forKey: "wontShowRestartNoticeAgain"
    )
    self.userHasMadeOnRestartChoice = UserDefaults.standard.bool(
      forKey: "userHasMadeOnRestartChoice"
    )
    self.willKeepNamesOnRestart = UserDefaults.standard.bool(
      forKey: "willKeepNamesOnRestart"
    )
  }

  func updateSettings(for key: String, with value: Any) {
    UserDefaults.standard.set(value, forKey: key)
  }

}
