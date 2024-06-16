//
//  DTO+CheckDuplicatedIdRequest.swift
//  SUWIKI
//
//  Created by 한지석 on 4/10/24.
//

import Foundation

extension DTO {
  public struct CheckDuplicatedIdRequest: Encodable {
    public let loginId: String
    
    public init(loginId: String) {
      self.loginId = loginId
    }
  }
}
