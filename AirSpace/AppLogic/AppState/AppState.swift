//
//  AppState.swift
//  AirSpace
//
//  Created by Hazel Nishad on 12/28/25.
//

import Foundation

enum RootState: Hashable {
  case onboarding
  case switcher
}

enum OnboardingState: Hashable {
  case firstOpen
  case noticeRelaunch
  case noticeKeepNames
  case setupKeepNamesStart
  case setupKeepNamesStop
  case setupCleanStart
  case setupCleanStop
}

enum SwitcherState: Hashable {
  case listView
  case gridView
}
