//
//  KeychainRepository.swift
//  SUWIKI
//
//  Created by 한지석 on 2/3/24.
//

import Foundation

protocol KeychainRepository {
    var keychainManager: KeychainManager { get }
    func create(token: TokenType, value: String)
    func read(token: TokenType) -> String?
}
