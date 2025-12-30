//
//  OnboardingDataModel.swift
//  AirSpace
//
//  Created by Hazel Nishad. on 12/30/25.
//

import Foundation
import SwiftUI

struct OnboardingDataModel: Identifiable {
  let id: UUID
  let title: String
  let subtitle: String
  let contentView: any View
}
