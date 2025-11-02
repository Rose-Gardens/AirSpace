//
//  SpaceObserver.swift
//  AirSpace
//
//  Created by Roshin Nishad on 9/20/25.
//

import Foundation

typealias SpaceID = UUID

struct SpaceModel: Identifiable, Codable {
  let id: SpaceID
  let numericalId: Int
  var customName: String
  var firstSeen: Date
  var lastSeen: Date
}

struct SpaceModelSnapshot {
  let currentSpaceId: SpaceID
  let spaces: [SpaceModel]
}

@MainActor
final class AnchorWindowMananger {
  static let shared = AnchorWindowMananger()
  
  private init() {}
  
  @discardableResult
  func openNewWindow() -> UUID {
    return UUID()
  }
  
}
