//
//  UserInfoUseCase.swift
//  SUWIKI
//
//  Created by 한지석 on 4/4/24.
//

import Foundation

import DIContainer

public protocol UserInfoUseCase {
  func execute() async throws -> UserInfo
}

public final class DefaultUserInfoUseCase: UserInfoUseCase {
  @Inject private var repository: UserRepository
  
  public init() { }
  
  public func execute() async throws -> UserInfo {
    return try await repository.userInfo()
  }
}
