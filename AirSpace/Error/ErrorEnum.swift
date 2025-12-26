//
//  ErrorEnum.swift
//  AirSpace
//
//  Created by Hazel Nishad on 12/25/25.
//

import Foundation

enum AppError: LocalizedError {
  case missingDirectoryError
  case anchorWindowNotCreatedError
  case cantConvertStringToJson

  var errorDescription: String? {
    switch self {
    case .missingDirectoryError:
      "Cannot access the Application Support Directory"
    case .anchorWindowNotCreatedError:
      "Anchor window unable to be created in this space"
    case .cantConvertStringToJson:
      "String to JSON conversion has failed"
    }
  }
}
