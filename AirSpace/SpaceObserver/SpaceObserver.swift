//
//  SpaceObserver.swift
//  AirSpace
//
//  Created by Hazel Nishad 🏳️‍⚧️ on 9/20/25.
//

import AppKit

typealias DisplayID = String

@MainActor
final class AirSpaceMananger: ObservableObject {

  // MARK: Simulates the singleton pattern by having one shared object
  static let shared = AirSpaceMananger(
    isRecordingSetup: false,
    spaceListPerDisplay: [:]
  )

  var isRecordingSetup: Bool
  var spaceListPerDisplay: [DisplayID: [SpaceRecord]]  // The Main List of Spaces

  private init(
    isRecordingSetup: Bool,
    spaceListPerDisplay: [DisplayID: [SpaceRecord]]
  ) {
    self.isRecordingSetup = isRecordingSetup
    self.spaceListPerDisplay = spaceListPerDisplay
  }

  // Called everytime there is a space change notification
  @objc func orchestrator() {

    // TODO: Check if in recording mode or current space not in dict here
    createSpaceRecord()
  }

  private func createDisplayRef() -> String {
    let currentDisplayID = NSScreen.main?.localizedName ?? "Display-Main"
    if self.spaceListPerDisplay.keys.contains(currentDisplayID) {
      return currentDisplayID
    }
    self.spaceListPerDisplay[currentDisplayID] = []
    return currentDisplayID
  }

  func createSpaceRecord() {
    // Everytime we create a new space, we first check if its in a new display, else use cur. display
    let currentDisplayID = createDisplayRef()
    // Get number of spaces based on the number of Space Records in that display, else 0
    let currentIndex = self.spaceListPerDisplay[currentDisplayID]?.count ?? 0
    if self.isRecordingSetup {

      // TODO: Update lastSeen on spaceChangeNotif, but we'll need window anchors first

      self.spaceListPerDisplay[currentDisplayID]?
        .append(
          SpaceRecord(
            id: UUID(),
            numericalId: currentIndex + 1,
            customName: "Desktop \(currentIndex + 1)",
            firstSeen: Date(),
            lastSeen: nil
          )
        )
    }
    // TODO: if we are on a new space without an anchor window when not recording, create one
  }

  func createWindowAnchor() {
    
  }
  
  func updateLastSeen() {
    
  }

}
