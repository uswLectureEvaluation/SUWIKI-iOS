//
//  ReadTokenUseCase.swift
//  SUWIKI
//
//  Created by 한지석 on 2/4/24.
//

import Foundation

import DIContainer

protocol ReadTokenUseCase {
    func excute(token: TokenType) -> String?
}

final class DefaultReadTokenUseCase: ReadTokenUseCase {
    @Inject var repository: KeychainRepository
    func excute(token: TokenType) -> String? {
        repository.read(token: token)
    }
}
