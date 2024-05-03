//
//  CreateTokenUseCase.swift
//  SUWIKI
//
//  Created by 한지석 on 2/4/24.
//

import Foundation

import DIContainer
import Keychain

public protocol CreateTokenUseCase {
    func excute(
        token: TokenType,
        value: String
    )
}

public final class DefaultCreateTokenUseCase: CreateTokenUseCase {
    @Inject private var repository: KeychainRepository

    public init() { }

    public func excute(
        token: TokenType,
        value: String
    ) {
        repository.create(
            token: token,
            value: value
        )
    }
}
