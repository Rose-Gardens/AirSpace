//
//  AppState.swift
//  AirSpace
//
//  Created by Hazel Nishad on 12/28/25.
//

import Foundation
import SwiftUI

enum RootState: Hashable {
  case onboarding
  case switcher
}

enum OnboardingState: Hashable {
  case firstOpen
  case noticeRestart
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

@MainActor
final class AppState: ObservableObject {

  // The singleton shared object ----
  static let shared = AppState(
    activeRootState: .onboarding,
    activeOnboardingState: .firstOpen,
    activeSwitcherState: .listView
  )

  // The properties of the class ----
  @Published var activeRootState: RootState
  @Published var activeOnboardingState: OnboardingState
  @Published var activeSwitcherState: SwitcherState

  // The constructor of the class (accessed only by 'shared') ----
  private init(
    activeRootState: RootState,
    activeOnboardingState: OnboardingState,
    activeSwitcherState: SwitcherState
  ) {
    self.activeRootState = activeRootState
    self.activeOnboardingState = activeOnboardingState
    self.activeSwitcherState = activeSwitcherState
  }

  @ViewBuilder
  func getRootContentView() -> some View {
    switch self.activeRootState {
    case .onboarding:
      OnboardingRootView()
    case .switcher:
      switch self.activeSwitcherState {
      case .listView:
        SwitcherListView()
      case .gridView:
        SwitcherGridView()
      }
    }
  }

  @ViewBuilder
  func getOnboardingContentView() -> some View {
    switch self.activeOnboardingState {
    case .firstOpen:
      FirstOpenView()
    case .noticeRestart:
      RestartNotice()
    case .noticeKeepNames:
      KeepNamesNotice()
    case .setupKeepNamesStart:
      SetupStartView()
    case .setupKeepNamesStop:
      SetupStopView()
    case .setupCleanStart:
      SetupStartView()
    case .setupCleanStop:
      SetupStopView()
    }

  }
}
