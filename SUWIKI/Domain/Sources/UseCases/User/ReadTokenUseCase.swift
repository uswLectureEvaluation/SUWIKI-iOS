//
//  ReadTokenUseCase.swift
//  SUWIKI
//
//  Created by 한지석 on 2/4/24.
//

import Foundation

import DIContainer
import Keychain

public protocol ReadTokenUseCase {
    func excute(
        token: TokenType
    ) -> String?
}

public final class DefaultReadTokenUseCase: ReadTokenUseCase {
    @Inject private var repository: KeychainRepository
    
    public init() { }

    public func excute(
        token: TokenType
    ) -> String? {
        repository.read(token: token)
    }
}
