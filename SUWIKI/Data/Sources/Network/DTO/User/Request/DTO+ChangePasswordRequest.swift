//
//  DTO+ResetPasswordRequest.swift
//  SUWIKI
//
//  Created by 한지석 on 4/8/24.
//

import Foundation

extension DTO {
  public struct ChangePasswordRequest: Encodable {
    public let prePassword: String
    public let newPassword: String
    
    public init(
      prePassword: String,
      newPassword: String
    ) {
      self.prePassword = prePassword
      self.newPassword = newPassword
    }
  }
}
