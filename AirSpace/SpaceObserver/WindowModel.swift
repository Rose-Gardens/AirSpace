//
//  WindowModel.swift
//  AirSpace
//
//  Created by Hazel Nishad on 12/21/25.
//

import AppKit

struct WindowModel: Identifiable {
  let id = UUID()
  var spaceID: Int
  let window: NSWindow
}
