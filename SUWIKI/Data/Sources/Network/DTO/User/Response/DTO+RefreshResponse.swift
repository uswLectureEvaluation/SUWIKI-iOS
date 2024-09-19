//
//  DTO+RefreshResponse.swift
//  SUWIKI
//
//  Created by 한지석 on 2/27/24.
//

import Foundation

extension DTO {
  public struct RefreshResponse: Codable {
    public let RefreshToken: String
    public let AccessToken: String
    
    public init(
      RefreshToken: String, 
      AccessToken: String
    ) {
      self.RefreshToken = RefreshToken
      self.AccessToken = AccessToken
    }
  }
}
