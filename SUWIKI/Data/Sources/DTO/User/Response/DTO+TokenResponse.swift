//
//  DTO+TokenResponse.swift
//  SUWIKI
//
//  Created by 한지석 on 2/2/24.
//

import Foundation

import Domain

extension DTO {
  public struct TokenResponse: Codable {
    /// 액세스 토큰
    public let AccessToken: String
    /// 리프레쉬 토큰
    public let RefreshToken: String
    
    public init(
      AccessToken: String,
      RefreshToken: String
    ) {
      self.AccessToken = AccessToken
      self.RefreshToken = RefreshToken
    }
  }
}

extension DTO.TokenResponse {
  var entity: SignIn {
    SignIn(
      accessToken: AccessToken,
      refreshToken: RefreshToken
    )
  }
}
