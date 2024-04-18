//
//  ChangePasswordUseCase.swift
//  SUWIKI
//
//  Created by 한지석 on 4/8/24.
//

import Foundation

import DIContainer

protocol ChangePasswordUseCase {
    func execute(
        current: String,
        new: String
    ) async throws -> Bool
}

final class DefaultChangePasswordUseCase: ChangePasswordUseCase {
    @Inject var repository: UserRepository

    func execute(
        current: String,
        new: String
    ) async throws -> Bool {
        return try await repository.changePassword(current: current, new: new)
    }
}
