//
//  CheckDuplicatedIdUseCase.swift
//  SUWIKI
//
//  Created by 한지석 on 4/10/24.
//

import Foundation

import DIContainer

public protocol CheckDuplicatedIdUseCase {
    func execute(
        id: String
    ) async throws -> Bool
}

public final class DefaultCheckDuplicatedIdUseCase: CheckDuplicatedIdUseCase {
    @Inject private var repository: UserRepository

    public init() { }

    public func execute(
        id: String
    ) async throws -> Bool {
        return try await repository.checkDuplicatedId(id: id)
    }
}
