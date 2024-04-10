//
//  FindPasswordUseCase.swift
//  SUWIKI
//
//  Created by 한지석 on 4/10/24.
//

import Foundation

protocol FindPasswordUseCase {
    func execute(id: String, email: String) async throws -> Bool
}

final class DefaultFindPasswordUseCase: FindPasswordUseCase {
    @Inject var repository: UserRepository

    func execute(id: String, email: String) async throws -> Bool {
        return try await repository.findPassword(id: id, email: email)
    }
}
