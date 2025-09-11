//
//  MenuItem.swift
//  AirSpace
//
//  Created by Roshin Nishad on 9/11/25.
//

import SwiftUI

struct MenuItem: Identifiable {
  let id = UUID()
  let title: String
  let shortcutTitle: String?
  let shortcut: KeyEquivalent?
  let action: () -> Void
}
