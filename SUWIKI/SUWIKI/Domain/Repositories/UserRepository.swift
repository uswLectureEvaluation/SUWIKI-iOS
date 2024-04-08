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
    ) async throws -> Bool
    func join() -> Bool
    func checkId() -> Bool
    func checkEmail() -> Bool
    func userInfo() async throws -> UserInfo
    func changePassword(
        current: String, 
        new: String
    ) async throws -> Bool
}
