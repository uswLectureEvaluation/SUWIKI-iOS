//
//  UserInfoUseCase.swift
//  SUWIKI
//
//  Created by 한지석 on 4/4/24.
//

import Foundation

import DIContainer

protocol UserInfoUseCase {
    func execute() async throws -> UserInfo
}

final class DefaultUserInfoUseCase: UserInfoUseCase {
    @Inject var repository: UserRepository

    func execute() async throws -> UserInfo {
        return try await repository.userInfo()
    }
}
