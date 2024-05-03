//
//  UserRepository.swift
//  SUWIKI
//
//  Created by 한지석 on 2/3/24.
//

import Foundation

public protocol UserRepository {
    func login(
        id: String,
        password: String
    ) async throws -> Bool
    func join(
        id: String,
        password: String,
        email: String
    ) async throws -> Bool
    func checkDuplicatedId(id: String) async throws -> Bool
    func checkDuplicatedEmail(email: String) async throws -> Bool
    func findId(email: String) async throws -> Bool
    func findPassword(
        id: String,
        email: String
    ) async throws -> Bool
    func userInfo() async throws -> UserInfo
    func changePassword(
        current: String,
        new: String
    ) async throws -> Bool
    func withDraw(
        id: String,
        password: String
    ) async throws -> Bool
}
