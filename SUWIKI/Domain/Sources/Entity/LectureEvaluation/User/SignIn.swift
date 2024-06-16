//
//  SignIn.swift
//  SUWIKI
//
//  Created by 한지석 on 2/5/24.
//

import Foundation

/// 유저 로그인
public struct SignIn {
  /// 액세스 토큰
  public let accessToken: String
  /// 리프레쉬 토큰
  public let refreshToken: String
  
  public init(
    accessToken: String,
    refreshToken: String
  ) {
    self.accessToken = accessToken
    self.refreshToken = refreshToken
  }
}
