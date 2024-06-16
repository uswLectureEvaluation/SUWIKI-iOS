//
//  DTO+RefreshRequest.swift
//  SUWIKI
//
//  Created by 한지석 on 2/27/24.
//

import Foundation

extension DTO {
  public struct RefreshRequest: Encodable {
    public let authorization: String

    public init(authorization: String) {
      self.authorization = authorization
    }
  }
}
