//
//  SignInUseCase.swift
//  SUWIKI
//
//  Created by 한지석 on 2/4/24.
//

import Foundation

import DIContainer

public protocol SignInUseCase {
    func excute(
        id: String,
        password: String
    ) async throws -> Bool
}

public final class DefaultSignInUseCase: SignInUseCase {
    @Inject private var repository: UserRepository

    public init() { }

    public func excute(
        id: String,
        password: String
    ) async throws -> Bool {
        try await repository.login(
            id: id,
            password: password
        )
    }
}
