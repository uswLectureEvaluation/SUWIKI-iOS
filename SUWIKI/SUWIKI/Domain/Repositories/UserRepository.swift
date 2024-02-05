//
//  UserRepository.swift
//  SUWIKI
//
//  Created by 한지석 on 2/3/24.
//

import Foundation

protocol UserRepository {
    func login(
        id: String,
        password: String
    ) async throws -> SignIn
    func join() -> Bool
    func checkId() -> Bool
    func checkEmail() -> Bool
}
