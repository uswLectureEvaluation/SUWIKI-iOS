//
//  CreateTokenUseCase.swift
//  SUWIKI
//
//  Created by 한지석 on 2/4/24.
//

import Foundation

import DIContainer

protocol CreateTokenUseCase {
    func excute(
        token: TokenType,
        value: String
    )
}

final class DefaultCreateTokenUseCase: CreateTokenUseCase {
    @Inject var repository: KeychainRepository

    func excute(
        token: TokenType,
        value: String
    ) {
        repository.create(token: token, value: value)
    }
}
