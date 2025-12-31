//
//  OnboardingViewModel.swift
//  AirSpace
//
//  Created by Hazel Nishad. on 12/30/25.
//

import Foundation
import SwiftUI

extension OnboardingRootView {
  @Observable
  @MainActor
  class OnboardingViewModel {

    let appState = AppState.shared

    var content: (title: String, subtitle: String) {
      switch appState.activeOnboardingState {
      case .firstOpen:
        (
          title: "Welcome to AirSpace!", subtitle: "Welcome! Glad you’re here 💖"
        )
      case .noticeRestart:
        (
          title: "AirSpace Restart Notice",
          subtitle: "AirSpace has been restarted."
        )
      case .noticeKeepNames:
        (
          title: "Keep Previous Space Names?",
          subtitle: "AirSpace has saved your previous space names.",
        )
      case .setupKeepNamesStart:
        (
          title: "Setup AirSpace (Keep Names)",
          subtitle: "Steps:",
        )
      case .setupKeepNamesStop:
        (
          title: "Capturing Spaces Started...",
          subtitle: "Steps:",
        )
      case .setupCleanStart:
        (
          title: "Setup AirSpace (New Setup)",
          subtitle: "Steps:",
        )
      case .setupCleanStop:
        (
          title: "Capturing Spaces Started...",
          subtitle: "Steps:",
        )
      }
    }
  }

}
