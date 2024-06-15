//
//  CheckDuplicatedEmailUseCase.swift
//  SUWIKI
//
//  Created by 한지석 on 4/10/24.
//

import Foundation

import DIContainer

public protocol CheckDuplicatedEmailUseCase {
  func execute(
    email: String
  ) async throws -> Bool
}

public final class DefaultCheckDuplicatedEmailUseCase: CheckDuplicatedEmailUseCase {
  @Inject private var repository: UserRepository
  
  public init() { }
  
  public func execute(
    email: String
  ) async throws -> Bool {
    return try await repository.checkDuplicatedEmail(email: email)
  }
}
