//
//  DTO+UserInfoRequest.swift
//  SUWIKI
//
//  Created by 한지석 on 4/4/24.
//

import Foundation

extension DTO {
  public struct UserInfoRequest: Encodable {
    public let authorization: String
    
    public init(authorization: String) {
      self.authorization = authorization
    }
  }
}
