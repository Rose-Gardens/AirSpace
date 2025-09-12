//
//  FirstTimeView.swift
//  AirSpace
//
//  Created by Roshin Nishad on 9/13/25.
//

import SwiftUI

struct FirstTimeView: View {

  @Binding var curContent: Content

  var body: some View {
    Text("A Quick Notice")
      .fontWeight(.semibold)
    VStack(alignment: .leading, spacing: 20) {
      Text(
        "AirSpace can only detect and switch to spaces that you first visit using macOS."
      )
      .fixedSize(horizontal: false, vertical: true)
      Text(
        "AirSpace can only detect the removal of a space once you try to visit it."
      )
      .fixedSize(horizontal: false, vertical: true)
      Text(
        "To use AirSpace, you’ll have to go through a quick setup process, by pressing Begin."
      )
      .fixedSize(horizontal: false, vertical: true)
    }
    Button("Begin Setup") {
      curContent = .setup
    }
  }

}
