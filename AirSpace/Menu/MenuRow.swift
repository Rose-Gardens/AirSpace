//
//  MenuRow.swift
//  AirSpace
//
//  Created by Roshin Nishad on 9/11/25.
//

import SwiftUI

struct MenuRow: View {
  let item: MenuItem
  @State private var hovered = false

  var body: some View {
    let mRow = Button(action: item.action) {
      HStack {
        Text(item.title)
        Spacer()
        if let keyText = item.shortcutTitle {
          Text(keyText)
            .foregroundStyle(
              hovered ? .primary : .tertiary
            )
        }
      }
      .frame(maxWidth: .infinity, alignment: .leading)
      .padding(horizontal: 4, vertical: 1)
      .contentShape(Rectangle())
    }
    .buttonStyle(.plain)
    .onHover { hovered = $0 }
    .background {
      if hovered {
        EffectMaterial(material: .selection)
          .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
          .padding(horizontal: -8, vertical: -4)
      }
    }
    .zIndex(hovered ? 1 : 0)

    if let key = item.shortcut {
      mRow.keyboardShortcut(key)
    } else {
      mRow
    }
  }
}
