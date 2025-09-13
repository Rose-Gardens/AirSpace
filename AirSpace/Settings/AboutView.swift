//
//  AboutView.swift
//  AirSpace
//
//  Created by Roshin Nishad on 9/13/25.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
      VStack(spacing: 8) {
        Image(systemName: "flower")
        Text("Version 0.1.0").font(.footnote)
        Text("Copyright © 2025 Rose Gardens. All Rights Reserved.").font(.footnote)
      }
    }
}
