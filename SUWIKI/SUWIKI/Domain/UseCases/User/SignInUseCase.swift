//
//  SignInUseCase.swift
//  SUWIKI
//
//  Created by 한지석 on 2/4/24.
//

import Foundation

import DIContainer

protocol SignInUseCase {
    func excute(
        id: String,
        password: String
    ) async throws -> Bool
}

final class DefaultSignInUseCase: SignInUseCase {
    @Inject var repository: UserRepository

    func excute(
        id: String,
        password: String
    ) async throws -> Bool {
        try await repository.login(id: id, password: password)
    }
}
