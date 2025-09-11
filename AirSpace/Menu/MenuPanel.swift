//
//  MenuPanel.swift
//  AirSpace
//
//  Created by Roshin Nishad on 9/11/25.
//

import SwiftUI

struct MenuPanel: View {
  var items: [MenuItem]
  
    var body: some View {
      VStack {
        ForEach(items) { item in
          MenuRow(item: item)
        }
      }
    }
}
