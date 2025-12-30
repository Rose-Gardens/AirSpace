//
//  AppDelegate.swift
//  AirSpace
//
//  Created by Hazel Nishad on 10/19/25.
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

let panelSize = NSSize(width: 360, height: 1)
let screenSize = NSScreen.main?.frame.size ?? .zero

var panelPosCoords: (x: Double, y: Double) {
  if let statusItemCoords = statusItem.button!.window?.convertToScreen(
    statusItem.button!.bounds
  ) {
    return (
      x: statusItemCoords.midX - panelSize.width / 2,
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

class AppDelegate: NSObject, NSApplicationDelegate, ObservableObject {

  var panelContentController: NSHostingController<AnyView>?
  var panelContentView: NSView?

  var panelView: NSPanelWithKey?
  var airSpace: AirSpaceMananger!
  var appState: AppState!

  func applicationDidFinishLaunching(_ notification: Notification) {

    let appSettings = AppSettings.shared
    appState = AppState.shared
    airSpace = AirSpaceMananger.shared

    // Had to resort to Gemini for the next 7 lines 😔
    let rootView = RootView().environmentObject(self)
    self.panelContentController = NSHostingController(
      rootView: AnyView(rootView)
    )
    if let controller = self.panelContentController {
      self.panelContentView = controller.view
    }

    // Trans affirmations on start-up 😌💖🏳️‍⚧️
    transCutie()
    airSpace.transPride(with: "🏳️‍⚧️")

    appSettings.registerUserDefaults()
    loadDiskData()

    statusItem.button?.title = "AirSpace..."
    statusItem.button?.action = #selector(showPanel)

    // MARK: Attaching didResignKeyNotif in createPanel makes below redundant
    // Close NSPanel if there's a click outside the panel
    //    NSEvent.addGlobalMonitorForEvents(matching: .leftMouseDown) { event in
    //      self.dismissPanel(using: event.locationInWindow)
    //    }

    NSWorkspace.shared.notificationCenter.addObserver(
      self,
      selector: #selector(
        spaceChangeHandler
      ),
      name: NSWorkspace.activeSpaceDidChangeNotification,
      object: nil,
    )

    appSettings.loadSettings()
  }

  @objc func spaceChangeHandler() {
    Task { @MainActor in
      guard let spaceRecord = airSpace.onSpaceChange() else { return }
      statusItem.button?.title = spaceRecord.customName
    }
  }

  func loadDiskData() {
    Task { @MainActor in
      if airSpace.checkIfDiskDataExists() {
        airSpace.loadRecordsFromDisk()
        appState.activeRootState = .onboarding
        //INSTRUCTIONS:
        // We need to have a user setting for dont show again restart notice
        appState.activeOnboardingState = .noticeRestart
      } else {
        print("No records.json exists. User will need to do a clean setup.")
      }
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
        .nonactivatingPanel,
        .utilityWindow,
      ],
      backing: .buffered,
      defer: false
    )
    guard let panel = panelView else { return }
    attachResignKeyNotifToPanel(for: panel)

    panel.level = .floating
    panel.collectionBehavior = [.canJoinAllSpaces, .fullScreenAuxiliary]
    panel.backgroundColor = .clear
    panel.ignoresMouseEvents = false
    panel.contentView = panelBackgroundAndContent()
  }

  func panelBackgroundAndContent() -> NSView {
    // Returns liquid glass as NSPanel background if macOS >= 26, else visEff as fallback
    if #available(macOS 26.0, *) {
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
    guard let contentView = panelContentView else { return NSView() }

    contentView.translatesAutoresizingMaskIntoConstraints = false
    visualEffect.addSubview(contentView)

    contentView.leadingAnchor.constraint(
      equalTo: visualEffect.leadingAnchor
    ).isActive = true
    contentView.trailingAnchor.constraint(
      equalTo: visualEffect.trailingAnchor
    ).isActive = true
    contentView.topAnchor.constraint(equalTo: visualEffect.topAnchor)
      .isActive = true
    contentView.bottomAnchor
      .constraint(equalTo: visualEffect.bottomAnchor).isActive = true

    return visualEffect
  }

  func attachResignKeyNotifToPanel(for panel: NSPanelWithKey) {
    NotificationCenter.default.addObserver(
      forName: NSWindow.didResignKeyNotification,
      object: panel,
      queue: nil
    ) { _ in
      self.dismissPanel(using: nil)
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

  func dismissPanel(using position: NSPoint?) {
    if let mouseClickPos = position {
      if panelView?.frame.contains(mouseClickPos) == true {
        return
      }
    }
    if panelView?.isVisible == true {
      panelView?.setIsVisible(false)
    }
  }

  func activatePanelAndBringToFront() {
    NSApp.activate()
    panelView?.makeKeyAndOrderFront(nil)
  }

  func transCutie() {
    var timeGreeting: String {
      let hour = Calendar.current.component(.hour, from: Date())
      switch hour {
      case 7..<12:
        return "Good Morning,"
      case 12..<17:
        return "Good Afternoon,"
      case 23...24, 0..<7:
        return "Hey sleepybun 😌🐰 :3, My"
      default:
        return "Good Evening,"
      }
    }
    let nameList = [
      "Hazeline", "Hazel", "hazelbun", "hornbun", "girlkissing hazelnut",
      "cutie :3", "kittybun", "cutiebun",
      "hottie 😌", "hazelnut girl", "gorgeous babe",
    ]
    let greetingsList = [
      "You cute little kittycat, meow 🐱", "You're a little girlkisser :3",
      "Mwah 😌💖",
      "My little bunbun girl 🥺", "You're adorable, you know that? :)",
    ]
    print(
      "\(timeGreeting) \(nameList.randomElement() ?? "")! \(greetingsList.randomElement() ?? "")"
    )
    print("I'm a trans cutie-pie! 🏳️‍⚧️😌💖")
  }

}
