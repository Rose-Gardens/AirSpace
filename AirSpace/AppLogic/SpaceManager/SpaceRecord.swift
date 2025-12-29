//
//  SpaceModel.swift
//  AirSpace
//
//  Created by Hazel Nishad on 11/11/25.
//

import AppKit

struct SpaceRecord: Identifiable, Codable {
  let id: UUID
  let numericalId: Int
  var customName: String
  var firstSeen: Date
  var lastSeen: Date?
}
