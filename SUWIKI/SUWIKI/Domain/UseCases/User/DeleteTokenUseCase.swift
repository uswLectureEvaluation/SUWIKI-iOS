//
//  DeleteTokenUseCase.swift
//  SUWIKI
//
//  Created by 한지석 on 2/4/24.
//

import Foundation

import DIContainer
import Keychain

protocol DeleteTokenUseCase {
    func excute(token: TokenType)
}

