//
//  DefaultKeychainRepository.swift
//  SUWIKI
//
//  Created by 한지석 on 2/3/24.
//

import Foundation

final class DefaultKeychainRepository: KeychainRepository {

    var keychainManager: KeychainManager = KeychainManager.shared

    func create(
        token: TokenType,
        value: String
    ) {
        keychainManager.create(
            token: token,
            value: value
        )
    }

    func read(
        token: TokenType
    ) -> String? {
        keychainManager.read(
            token: token
        )
    }
}
