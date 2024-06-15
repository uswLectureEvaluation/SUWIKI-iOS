//
//  SignUpUseCase.swift
//  SUWIKI
//
//  Created by 한지석 on 2/4/24.
//

import Foundation

import DIContainer

public protocol SignUpUseCase {
  func execute(
    id: String,
    password: String,
    email: String
  ) async throws -> Bool
}

public final class DefaultSignUpUseCase: SignUpUseCase {
  @Inject private var repository: UserRepository
  
  public init() { }
  
  public func execute(
    id: String,
    password: String,
    email: String
  ) async throws -> Bool {
    return try await repository.join(
      id: id,
      password: password,
      email: email
    )
  }
}
