//
//  DefaultKeychainRepository.swift
//  SUWIKI
//
//  Created by 한지석 on 2/3/24.
//

import Foundation

import Domain
import Keychain

public final class DefaultKeychainRepository: KeychainRepository {

    public let keychainManager = KeychainManager.shared

    public init() { }

    public func create(
        token: TokenType,
        value: String
    ) {
        keychainManager.create(
            token: token,
            value: value
        )
        print("@Log \(token) - \(value)")
    }

    public func read(
        token: TokenType
    ) -> String? {
        keychainManager.read(
            token: token
        )
    }
}
