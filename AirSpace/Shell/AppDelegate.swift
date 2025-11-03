//
//  AppDelegate.swift
//  AirSpace
//
//  Created by Roshin Nishad on 10/19/25.
//

import Cocoa

class NSPanelWithKey: NSPanel {
  override var canBecomeKey: Bool {
    return true
  }
}

let statusItem = NSStatusBar.system.statusItem(
  withLength: NSStatusItem.variableLength
)

var panelView: NSPanelWithKey?
let panelSize = NSSize(width: 360, height: 500)
let screenSize = NSScreen.main?.frame.size ?? .zero

var panelPosCoords: (x: Double, y: Double) {
  if let statusItemCoords = statusItem.button!.window?.convertToScreen(
    statusItem.button!.bounds
  ) {
    return (
      x: (statusItemCoords.midX - panelSize.width / 2),
      y: statusItemCoords.minY
    )
  } else {
    // Center of the screen
    return (
      x: (screenSize.width / 2 - panelSize.width / 2),
      y: (screenSize.height / 2 - panelSize.height / 2)
    )
  }
}

class AppDelegate: NSObject, NSApplicationDelegate {
  func applicationDidFinishLaunching(_ notification: Notification) {
    statusItem.button?.title = "Desktop 1"
    statusItem.button?.action = #selector(showPanel)

    // Close NSPanel if there's a click outside the panel
    NSEvent.addGlobalMonitorForEvents(matching: .leftMouseDown) { event in
      self.dismissPanel(using: event.locationInWindow)
    }

  }

  @objc func showPanel() {
    guard panelView == nil else {
      togglePanel()
      return
    }
    let rect = NSMakeRect(
      panelPosCoords.x,
      panelPosCoords.y,
      panelSize.width,
      panelSize.height
    )
    createPanel(with: rect)
    activatePanelAndBringToFront()
  }

  func createPanel(with rect: NSRect) {
    panelView = NSPanelWithKey(
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
  }

  func panelBackground() -> NSView {
    if #available(macOS 26.0, *) {
      let visualEffect = NSGlassEffectView()
      visualEffect.cornerRadius = 24
      visualEffect.style = .regular
      // Added to prevent keyWindow chrome having a different c.radius
      visualEffect.wantsLayer = true
      visualEffect.layer?.cornerRadius = 24
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

  @objc func togglePanel() {
    if panelView?.isVisible == true {
      panelView?.setIsVisible(false)
    } else {
      panelView?.setFrameOrigin(
        CGPoint(
          x: panelPosCoords.x,
          y: panelPosCoords.y
        )
      )
      activatePanelAndBringToFront()
    }
  }

  func dismissPanel(using position: NSPoint) {
    if panelView?.frame.contains(position) == true {
      return
    }
    if panelView?.isVisible == true {
      panelView?.setIsVisible(false)
    }
  }

  func activatePanelAndBringToFront() {
    NSApp.activate()
    panelView?.makeKeyAndOrderFront(nil)
  }

}
