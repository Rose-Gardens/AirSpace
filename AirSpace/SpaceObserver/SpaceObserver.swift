//
//  SpaceObserver.swift
//  AirSpace
//
//  Created by Hazel Nishad on 9/20/25.
//

import AppKit
import SwiftyJSON

typealias DisplayID = String
typealias SpaceID = UUID

@MainActor
final class AirSpaceMananger: NSObject, ObservableObject {

  // The singleton shared object ----
  static let shared = AirSpaceMananger(
    isRecording: false,
    spaceListPerDisplay: [:],
    spacePerAnchor: [:]
  )

  // The properties of the class ----
  var isRecording: Bool
  var spaceListPerDisplay: [DisplayID: [SpaceRecord]]  // The Main List of Spaces
  var spacePerAnchor: [NSWindow?: Int]

  // The constructor of the class (accessed only by 'shared') ----
  private init(
    isRecording: Bool,
    spaceListPerDisplay: [DisplayID: [SpaceRecord]],
    spacePerAnchor: [NSWindow?: Int]
  ) {
    self.isRecording = isRecording
    self.spaceListPerDisplay = spaceListPerDisplay
    self.spacePerAnchor = spacePerAnchor
  }

  // ! The space change notification entry point ----
  @discardableResult
  func onSpaceChange() -> SpaceRecord? {
    if shouldCreateSpaceRecord() {
      createSpaceRecord()
    }
    dealWith2ormoreAnchorsInSpace()
    
    guard let spaceRecord = getRecordOfActiveSpace() else { return nil }
    return spaceRecord
  }

  // --------------- *Methods of AirSpace* ----------------

  private func shouldCreateSpaceRecord() -> Bool {
    guard getActiveSpaceWindows().count == 0 else { return false }
    return self.isRecording
      || AppSettings.shared.willAutoCreateRecordInNormalMode
  }

  // Return current display ID if it exists, else create one and return ----
  private func getCurrentDisplayID() -> String {
    let currentDisplayID = NSScreen.main?.localizedName ?? "Display-Main"
    if self.spaceListPerDisplay.keys.contains(currentDisplayID) {
      return currentDisplayID
    }
    self.spaceListPerDisplay[currentDisplayID] = []
    return currentDisplayID
  }

  // The only place a SpaceRecord is created ----
  func createSpaceRecord() {
    var isNormalModeSpaceRecord = false
    let currentDisplayID = getCurrentDisplayID()
    let lastSpaceIndex = self.spaceListPerDisplay[currentDisplayID]?.count ?? 0
    let newSpaceID = SpaceID()
    var spaceName = "Desktop \(lastSpaceIndex + 1)"
    if !self.isRecording {
      // Since we can never know if user went to the space on the left or right,
      // always placing the new spaceRec at the end (in non-record mode) is the safest bet.
      // We'll add in a '?' at the end of the name if the spaceRec was made when not in rec. mode
      // Drag and drop in the UI will be the user's solution to fix this.
      spaceName = "\(spaceName)?"
      isNormalModeSpaceRecord = true
    }
    // TODO: Update lastSeen on spaceChangeNotif (not here?), but we'll need window anchors first
    self.spaceListPerDisplay[currentDisplayID]?
      .append(
        SpaceRecord(
          id: newSpaceID,
          numericalId: lastSpaceIndex + 1,
          customName: spaceName,
          firstSeen: Date(),
          lastSeen: nil
        )
      )
    if let anchorWindow = createWindowAnchor(at: lastSpaceIndex) {
      self.spacePerAnchor[anchorWindow] = lastSpaceIndex
    }

    if isNormalModeSpaceRecord {
      saveRecordsToDisk()
    }
  }

  func createWindowAnchor(at spaceIndex: Int) -> NSWindow? {
    guard getActiveSpaceWindows().count == 0 else { return nil }
    let anchorWindow = NSWindow(
      contentRect: NSRect(
        x: 0,
        y: 0,
        width: 100,
        height: 100
      ),
      styleMask: [.borderless],
      backing: .buffered,
      defer: false
    )
    //    anchorWindow.collectionBehavior = [
    //      .ignoresCycle,
    //      .fullScreenNone,
    //      .stationary,
    //      .auxiliary,
    //    ]
    anchorWindow.backgroundColor = .red
    //    anchorWindow.backgroundColor = .clear
    //    anchorWindow.isOpaque = false
    //    anchorWindow.ignoresMouseEvents = true
    //    anchorWindow.hasShadow = false
    anchorWindow.orderFrontRegardless()
    do {
      guard getActiveSpaceWindows().count == 1 else {
        throw AppError.anchorWindowNotCreatedError
      }
    } catch {
      print("\(error.localizedDescription): for space \(spaceIndex)")
    }
    return anchorWindow
  }

  func updateLastSeen() {
    // INSTRUCTIONS:
    // everytime space change notif happens, whatever is the current anchor,
    // gets the last seen new date, then the current anchor state changes
  }

  func getActiveSpaceWindows() -> [NSWindow] {
    let airSpaceWindows = NSApplication.shared.orderedWindows
    let airSpaceWindowsInActiveSpace = airSpaceWindows.filter {
      $0.isOnActiveSpace
    }
    return airSpaceWindowsInActiveSpace

  }

  func getRecordOfActiveSpace() -> SpaceRecord? {
    guard let anchor = getActiveSpaceWindows().first else { return nil }
    guard let spaceIndex = spacePerAnchor[anchor] else { return nil }
    guard let spaceRecordList = spaceListPerDisplay[getCurrentDisplayID()]
    else { return nil }
    return spaceRecordList[spaceIndex]
  }

  func getDiskSavePath() throws -> URL {
    guard
      let applicationSupport = FileManager.default.urls(
        for: .applicationSupportDirectory,
        in: .userDomainMask
      ).first
    else {
      throw AppError.missingDirectoryError
    }
    let savePath = applicationSupport.appendingPathComponent(
      "records.json",
      conformingTo: .json
    )
    return savePath
  }

  func saveRecordsToDisk() {
    do {
      let savePath = try getDiskSavePath()
      let json = try JSONEncoder().encode(spaceListPerDisplay)
      try json.write(to: savePath)
    } catch {
      // INSTRUCTIONS:
      // Error thingy for user like in the UI
      print("Saving data to disk has failed: \(error.localizedDescription)")
    }
  }

  func loadRecordsFromDisk() {
    do {
      let savePath = try getDiskSavePath()
      let data = try String(contentsOf: savePath, encoding: .utf8)
      guard
        let dataFromString = data.data(
          using: .utf8,
          allowLossyConversion: false
        )
      else {
        throw AppError.cantConvertStringToJson
      }
      let json = try JSON(data: dataFromString)

      // TODO: DOES THIS LINE OF CODE WORK AS EXPECTED???
      if json.isEmpty {
        return
      }

      var tempSpaceListPerDisplay: [DisplayID: [SpaceRecord]] = [:]
      for (key, subJson): (String, JSON) in json {
        tempSpaceListPerDisplay[key] = []
        for (_, recordJson): (String, JSON) in subJson {
          tempSpaceListPerDisplay[key]?.append(
            SpaceRecord(
              id: SpaceID(),
              numericalId: recordJson["numericalId"].intValue,
              customName: recordJson["customName"].stringValue,
              firstSeen: Date(
                timeIntervalSinceReferenceDate: recordJson["firstSeen"]
                  .doubleValue
              ),
              lastSeen: nil
            )
          )
        }
      }
      self.spaceListPerDisplay = tempSpaceListPerDisplay
    } catch {
      // INSTRUCTIONS:
      // Error thingy for user like in the UI
      print("Loading data from disk has failed: \(error.localizedDescription)")
    }
  }

  func dealWith2ormoreAnchorsInSpace() {

  }

  func transPride(with flag: String) {
    print("Hazeline, Trans Girlie Forever! \(flag)✨💖")
  }
}
