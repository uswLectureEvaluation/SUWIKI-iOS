//
//  DTO+FindIdRequest.swift
//  SUWIKI
//
//  Created by 한지석 on 4/10/24.
//

import Foundation

extension DTO {
  public struct FindIdRequest: Encodable {
    public let email: String
    
    public init(email: String) {
      self.email = email
    }
  }
}
