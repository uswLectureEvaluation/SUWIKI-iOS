//
//  FindPasswordUseCase.swift
//  SUWIKI
//
//  Created by 한지석 on 4/10/24.
//

import Foundation

import DIContainer

public protocol FindPasswordUseCase {
  func execute(
    id: String,
    email: String
  ) async throws -> Bool
}

public final class DefaultFindPasswordUseCase: FindPasswordUseCase {
  @Inject private var repository: UserRepository
  
  public init() { }
  
  public func execute(
    id: String,
    email: String
  ) async throws -> Bool {
    return try await repository.findPassword(
      id: id,
      email: email
    )
  }
}
