//
//  SignUpUseCase.swift
//  SUWIKI
//
//  Created by 한지석 on 2/4/24.
//

import Foundation

import DIContainer

protocol SignUpUseCase {
    func execute(
        id: String,
        password: String,
        email: String
    ) async throws -> Bool
}

final class DefaultSignUpUseCase: SignUpUseCase {
    @Inject var repository: UserRepository

    func execute(
        id: String, 
        password: String,
        email: String
    ) async throws -> Bool {
        return try await repository.join(id: id, password: password, email: email)
    }
}
