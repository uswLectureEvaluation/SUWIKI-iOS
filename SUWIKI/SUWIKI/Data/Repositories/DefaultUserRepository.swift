//
//  DefaultUserRepository.swift
//  SUWIKI
//
//  Created by 한지석 on 2/4/24.
//

import Foundation

final class DefaultUserRepository: UserRepository {
    
    let keychainManager = KeychainManager.shared
    
    func login(
        id: String,
        password: String
    ) async throws -> Bool {
        let target = APITarget.User.login(
            DTO.LoginRequest(
                loginId: id,
                password: password
            )
        )
        do {
            let response = try await APIProvider.request(
                DTO.TokenResponse.self,
                target: target).entity
            keychainManager.create(token: .AccessToken, value: response.accessToken)
            keychainManager.create(token: .RefreshToken, value: response.refreshToken)
            return true
        } catch {
            return false
        }
    }
    
    func join() -> Bool {
        true
    }
    
    func checkId() -> Bool {
        true
    }
    
    func checkEmail() -> Bool {
        true
    }
    
    func userInfo() async throws -> UserInfo {
        let apiTarget = APITarget.User.userInfo
        let value = try await APIProvider.request(DTO.UserInfoResponse.self, target: apiTarget)
        return value.entity
    }
    
    func changePassword(
        current: String,
        new: String
    ) async throws -> Bool {
        let apiTarget = APITarget
            .User
            .changePassword(
                DTO.ChangePasswordRequest(
                    prePassword: current,
                    newPassword: new
                )
            )
        if let statusCode = try await APIProvider.request(target: apiTarget) {
            if statusCode == 200 {
                return true
            } else {
                return false
            }
        } else {
            return false
        }
    }
}
