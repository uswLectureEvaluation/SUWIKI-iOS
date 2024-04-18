//
//  WithDrawUseCase.swift
//  SUWIKI
//
//  Created by 한지석 on 4/11/24.
//

import Foundation

import DIContainer

protocol WithDrawUseCase {
    func execute(id: String, password: String) async throws -> Bool
}

final class DefaultWithDrawUseCase: WithDrawUseCase {
    @Inject var repository: UserRepository

    func execute(
        id: String,
        password: String
    ) async throws -> Bool {
        return try await repository.withDraw(id: id, password: password)
    }
}
