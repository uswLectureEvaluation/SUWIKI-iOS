//
//  ChangePasswordUseCase.swift
//  SUWIKI
//
//  Created by 한지석 on 4/8/24.
//

import Foundation

import DIContainer

public protocol ChangePasswordUseCase {
  func execute(
    current: String,
    new: String
  ) async throws -> Bool
}

public final class DefaultChangePasswordUseCase: ChangePasswordUseCase {
  @Inject private var repository: UserRepository
  
  public init() { }
  
  public func execute(
    current: String,
    new: String
  ) async throws -> Bool {
    return try await repository.changePassword(
      current: current,
      new: new
    )
  }
}
