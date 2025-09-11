//
//  Extensions.swift
//  AirSpace
//
//  Created by Roshin Nishad on 9/11/25.
//

import SwiftUI

// View: Padding Ext
extension View {
  func padding(horizontal: CGFloat, vertical: CGFloat) -> some View {
    self
      .padding(.horizontal, horizontal)
      .padding(.vertical, vertical)
  }
}
