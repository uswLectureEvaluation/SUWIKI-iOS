//
//  SignInUseCase.swift
//  SUWIKI
//
//  Created by 한지석 on 2/4/24.
//

import Foundation

protocol SignInUseCase {
    func excute(
        id: String,
        password: String
    ) async throws -> SignIn
}

final class DefaultSignInUseCase: SignInUseCase {

    @Inject var repository: UserRepository

    func excute(
        id: String,
        password: String
    ) async throws -> SignIn {
        try await repository.login(id: id, password: password)
    }

}
