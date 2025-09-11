//
//  EffectMaterial.swift
//  AirSpace
//
//  Created by Roshin Nishad on 9/11/25.
//

import AppKit
import SwiftUI

struct EffectMaterial: NSViewRepresentable {
  let material: NSVisualEffectView.Material
  var emphasized: Bool = true
  
  func makeNSView(context: Context) -> NSVisualEffectView {
    let view = NSVisualEffectView()
    view.material = material
    view.blendingMode = .withinWindow
    view.state = .active
    view.isEmphasized = emphasized
    return view
  }
  
  func updateNSView(_ view: NSViewType, context: Context) {
    view.material = material
    view.isEmphasized = emphasized
  }
  
}
