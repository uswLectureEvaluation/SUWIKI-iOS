//
//  DTO+WithDrawUserRequest.swift
//  SUWIKI
//
//  Created by 한지석 on 4/11/24.
//

import Foundation

extension DTO {
  public struct WithDrawUserRequest: Encodable {
    public let loginId: String
    public let password: String
    
    public init(
      loginId: String,
      password: String
    ) {
      self.loginId = loginId
      self.password = password
    }
  }
}
