//
//  CheckDuplicatedIdUseCase.swift
//  SUWIKI
//
//  Created by 한지석 on 4/10/24.
//

import Foundation

protocol CheckDuplicatedIdUseCase {
    func execute(id: String) async throws -> Bool
}

final class DefaultCheckDuplicatedIdUseCase: CheckDuplicatedIdUseCase {

    @Inject var repository: UserRepository

    func execute(id: String) async throws -> Bool {
        return try await repository.checkDuplicatedId(id: id)
    }
}
