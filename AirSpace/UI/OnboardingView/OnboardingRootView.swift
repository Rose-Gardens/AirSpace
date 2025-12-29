//
//  OnboardingRootView.swift
//  AirSpace
//
//  Created by Hazel Nishad on 8/9/25.
//

import SwiftUI

enum Content {
  case firstTime, setup, recording
}

struct OnboardingRootView: View {

  @State private var curContent: Content = .firstTime

  var body: some View {
    let isSetup = (curContent == .setup)

    // ------------ View Returned Below -------------

    VStack {
      HStack {
        if isSetup {
          Button {
            curContent = .firstTime
          } label: {
            Image(systemName: "chevron.backward")
          }
          .transition(.opacity)
          .padding(.trailing, 2)
        }
        Text(
          isSetup
            ? "Setup AirSpace." : "Welcome to AirSpace."
        )
        .font(.title2)
        .fontWeight(.bold)
        .contentTransition(.opacity)
        Spacer()
        Image(systemName: "airplane.departure")
          .font(.system(size: 20))
      }
      Divider()
      ZStack {
        VStack(spacing: 16) {

          switch curContent {
          case .firstTime:
            OnboardingWelcomeView(curContent: $curContent)
          case .setup:
            OnboardingSetupView(curContent: $curContent)
          case .recording:
            OnboardingRecordingView(curContent: $curContent)
          }

        }
        .padding(.vertical, 16)
      }
      .animation(.easeInOut, value: curContent)
    }
    // TODO: You can programmatically change the height using a fn!!
    .frame(
      maxWidth: .infinity,
      minHeight: 400,
      maxHeight: 400,
      alignment: .topLeading
    )
  }
}
