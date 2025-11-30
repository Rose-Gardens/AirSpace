//
//  AppDelegate.swift
//  AirSpace
//
//  Created by Roshin Nishad on 10/19/25.
//

import Cocoa
import SwiftUI

class NSPanelWithKey: NSPanel {
  override var canBecomeKey: Bool {
    return true
  }
}

let statusItem = NSStatusBar.system.statusItem(
  withLength: NSStatusItem.variableLength
)

var panelView: NSPanelWithKey?
let panelContentController = NSHostingController(rootView: RootView())
let panelContentView = panelContentController.view

let panelSize = NSSize(width: 360, height: 400)
let screenSize = NSScreen.main?.frame.size ?? .zero

var panelPosCoords: (x: Double, y: Double) {
  if let statusItemCoords = statusItem.button!.window?.convertToScreen(
    statusItem.button!.bounds
  ) {
    return (
      x: (statusItemCoords.midX - panelSize.width / 2),
      y: statusItemCoords.minY - panelSize.height
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
    
    let airSpace = AirSpaceMananger.shared
    
    // Close NSPanel if there's a click outside the panel
    NSEvent.addGlobalMonitorForEvents(matching: .leftMouseDown) { event in
      self.dismissPanel(using: event.locationInWindow)
    }

    NSWorkspace.shared.notificationCenter.addObserver(
      airSpace,
      selector: #selector(airSpace.orchestrator),
      name: NSWorkspace.activeSpaceDidChangeNotification,
      object: nil
    )

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
        .nonactivatingPanel,
        .utilityWindow,
      ],
      backing: .buffered,
      defer: false
    )
    guard let panel = panelView else { return }
    panel.level = .floating
    panel.collectionBehavior = [.canJoinAllSpaces, .fullScreenAuxiliary]
    panel.backgroundColor = .clear
    panel.ignoresMouseEvents = false
    panel.contentView = panelBackgroundAndContent()
  }

  func panelBackgroundAndContent() -> NSView {
    // Returns liquid glass as NSPanel background if macOS >= 26, else visEff as fallback
    if #available(macOS 29.0, *) {
      let visualEffect = NSGlassEffectView()
      visualEffect.cornerRadius = 24
      visualEffect.style = .regular

      // Added to prevent window chrome from having a different c.radius
      visualEffect.wantsLayer = true
      visualEffect.layer?.cornerRadius = 24

      visualEffect.contentView = panelContentView
      return visualEffect

    } else {
      let visualEffect = NSVisualEffectView()
      visualEffect.blendingMode = .behindWindow
      visualEffect.state = .active
      visualEffect.material = .hudWindow
      visualEffect.wantsLayer = true
      visualEffect.layer?.cornerRadius = 24
      visualEffect.layer?.borderWidth = 0.5
      visualEffect.layer?.borderColor =
        NSColor.gray.withAlphaComponent(0.8).cgColor
      // Removing the panel's shadow as it does not follow the correct c.radius
      panelView?.hasShadow = false

      let visualEffectWithContent = setPanelContent(for: visualEffect)
      return visualEffectWithContent
    }
  }

  func setPanelContent(for visualEffect: NSView) -> NSView {
    panelContentView.translatesAutoresizingMaskIntoConstraints = false
    visualEffect.addSubview(panelContentView)

    panelContentView.leadingAnchor.constraint(
      equalTo: visualEffect.leadingAnchor
    ).isActive = true
    panelContentView.trailingAnchor.constraint(
      equalTo: visualEffect.trailingAnchor
    ).isActive = true
    panelContentView.topAnchor.constraint(equalTo: visualEffect.topAnchor)
      .isActive = true
    panelContentView.bottomAnchor
      .constraint(equalTo: visualEffect.bottomAnchor).isActive = true

    return visualEffect
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
