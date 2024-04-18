//
//  FindIdUseCase.swift
//  SUWIKI
//
//  Created by 한지석 on 4/10/24.
//

import Foundation

import DIContainer

protocol FindIdUseCase {
    func execute(email: String) async throws -> Bool
}

final class DefaultFindIdUseCase: FindIdUseCase {
    @Inject var repository: UserRepository

    func execute(email: String) async throws -> Bool {
        return try await repository.findId(email: email)
    }
}
