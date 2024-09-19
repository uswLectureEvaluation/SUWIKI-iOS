//
//  DTO+CheckEmailRequest.swift
//  SUWIKI
//
//  Created by 한지석 on 2/3/24.
//

import Foundation

extension DTO {
  public struct CheckEmailRequest: Encodable {
    /// 학교 이메일
    public let email: String
    
    public init(email: String) {
      self.email = email
    }
  }
}
