//
//  AppDelegate.swift
//  AirSpace
//
//  Created by Roshin Nishad on 10/19/25.
//

import Cocoa

let statusItem = NSStatusBar.system.statusItem(
  withLength: NSStatusItem.variableLength
)

var panelView: NSPanel?

class AppDelegate: NSObject, NSApplicationDelegate {
  func applicationDidFinishLaunching(_ notification: Notification) {
    statusItem.button?.title = "Desktop 1"
    statusItem.button?.action = #selector(showPanel)
  }

  @objc func showPanel() {
    guard panelView == nil else {
      if panelView!.isVisible {
        panelView!.close()
      }
      else {
        panelView!.orderFrontRegardless()
      }
      return
    }

    let panelSize = NSSize(width: 360, height: 500)
    let screenSize = NSScreen.main?.frame.size ?? .zero
    let statusItemCoords = statusItem.button!.window?.convertToScreen(
      statusItem.button!.bounds
    )
    let rect = NSMakeRect(
      (statusItemCoords?.midX ?? screenSize.width / 2) - panelSize.width / 2,
      statusItemCoords?.maxY ?? (screenSize.height / 2 - panelSize.height / 2),
      panelSize.width,
      panelSize.height
    )
    panelView = NSPanel(
      contentRect: rect,
      styleMask: [
        .borderless,
        .fullSizeContentView,
        .utilityWindow,
        .nonactivatingPanel,
      ],
      backing: .buffered,
      defer: false
    )
    panelView?.level = .floating
    panelView?.collectionBehavior = [.canJoinAllSpaces, .fullScreenAuxiliary]
    panelView?.backgroundColor = .clear
    panelView?.contentView = panelBackground()
    panelView?.orderFrontRegardless()
  }

  func panelBackground() -> NSView {
    if #available(macOS 26.0, *) {
      let visualEffect = NSGlassEffectView()
      visualEffect.cornerRadius = 24
      visualEffect.style = .regular
      return visualEffect
    } else {
      let visualEffect = NSVisualEffectView()
      visualEffect.blendingMode = .behindWindow
      visualEffect.state = .active
      visualEffect.material = .hudWindow
      visualEffect.wantsLayer = true
      visualEffect.layer?.cornerRadius = 24
      return visualEffect
    }
  }
}
