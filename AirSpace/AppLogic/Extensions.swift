//
//  Extensions.swift
//  AirSpace
//
//  Created by Hazel Nishad on 9/11/25.
//

import SwiftUI

// View+Padding
extension View {
  func padding(horizontal: CGFloat, vertical: CGFloat) -> some View {
    self
      .padding(.horizontal, horizontal)
      .padding(.vertical, vertical)
  }

}

// Collection+isNotEmpty
extension Collection {
  var isNotEmpty: Bool {
    !self.isEmpty
  }
}
