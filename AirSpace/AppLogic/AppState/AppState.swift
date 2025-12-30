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

  let onboardingDefaultCase = OnboardingDataModel(
    id: UUID(),
    title: "Welcome to AirSpace!",
    subtitle: "Welcome! Glad you’re here 💖",
    contentView: FirstOpenView()
  )

  func getRootContentView(
    activeRootState: RootState,
    activeSwitcherState: SwitcherState
  ) -> any View {
    switch activeRootState {
    case .onboarding:
      return OnboardingRootView()
    case .switcher:
      switch activeSwitcherState {
      case .listView:
        return SwitcherListView()
      case .gridView:
        return SwitcherGridView()
      }
    }
  }

  func getOnboardingContentData(
    activeRootState: RootState,
    activeOnboardingState: OnboardingState
  ) -> OnboardingDataModel {
    switch activeRootState {
    case .onboarding:
      switch activeOnboardingState {
      case .firstOpen:
        return .init(
          id: UUID(),
          title: "Welcome to AirSpace!",
          subtitle: "Welcome! Glad you’re here 💖",
          contentView: FirstOpenView()
        )
      case .noticeRestart:
        return .init(
          id: UUID(),
          title: "AirSpace Restart Notice",
          subtitle: "AirSpace has been restarted.",
          contentView: RestartNotice()
        )
      case .noticeKeepNames:
        return .init(
          id: UUID(),
          title: "Keep Previous Space Names?",
          subtitle: "AirSpace has saved your previous space names.",
          contentView: KeepNamesNotice()
        )
      case .setupKeepNamesStart:
        return .init(
          id: UUID(),
          title: "Setup AirSpace (Keep Names)",
          subtitle: "Steps:",
          contentView: SetupStartView()
        )
      case .setupKeepNamesStop:
        return .init(
          id: UUID(),
          title: "Capturing Spaces Started...",
          subtitle: "Steps:",
          contentView: SetupStopView()
        )
      case .setupCleanStart:
        return .init(
          id: UUID(),
          title: "Setup AirSpace (New Setup)",
          subtitle: "Steps:",
          contentView: SetupStartView()
        )
      case .setupCleanStop:
        return .init(
          id: UUID(),
          title: "Capturing Spaces Started...",
          subtitle: "Steps:",
          contentView: SetupStopView()
        )
      }
    default:
      return onboardingDefaultCase
    }
  }
}
