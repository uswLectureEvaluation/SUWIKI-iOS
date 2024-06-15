//
//  WithDrawUseCase.swift
//  SUWIKI
//
//  Created by 한지석 on 4/11/24.
//

import Foundation

import DIContainer

public protocol WithDrawUseCase {
  func execute(
    id: String,
    password: String
  ) async throws -> Bool
}

public final class DefaultWithDrawUseCase: WithDrawUseCase {
  @Inject private var repository: UserRepository
  
  public init() { }
  
  public func execute(
    id: String,
    password: String
  ) async throws -> Bool {
    return try await repository.withDraw(
      id: id,
      password: password
    )
  }
}
