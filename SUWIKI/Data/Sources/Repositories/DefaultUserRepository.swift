//
//  DefaultUserRepository.swift
//  SUWIKI
//
//  Created by 한지석 on 2/4/24.
//

import Foundation

import Domain
import Keychain
import Network

public final class DefaultUserRepository: UserRepository {

    let keychainManager = KeychainManager.shared
    let apiProivder: APIProviderProtocol

    public init(apiProivder: APIProviderProtocol) {
        self.apiProivder = apiProivder
    }

    public func login(
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
            let response = try await apiProivder.request(
                DTO.TokenResponse.self,
                target: target).entity
            keychainManager.create(token: .AccessToken, value: response.accessToken)
            keychainManager.create(token: .RefreshToken, value: response.refreshToken)
            return true
        } catch {
            return false
        }
    }
    
    public func join(
        id: String,
        password: String,
        email: String
    ) async throws -> Bool {
        let apiTarget = APITarget.User.join(
            DTO.JoinRequest(loginId: id,
                            password: password,
                            email: email)
        )
        return try await apiProivder.request(target: apiTarget)
    }

    public func findId(email: String) async throws -> Bool {
        let apiTarget = APITarget.User.findId(DTO.FindIdRequest(email: email))
        return try await apiProivder.request(target: apiTarget)
    }

    public func findPassword(
        id: String,
        email: String
    ) async throws -> Bool {
        let apiTarget = APITarget.User.findPassword(DTO.FindPasswordRequest(loginId: id, email: email))
        return try await apiProivder.request(target: apiTarget)
    }

    public func checkDuplicatedId(id: String) async throws -> Bool {
        let apiTarget = APITarget.User.checkDuplicatedId(DTO.CheckDuplicatedIdRequest(loginId: id))
        let value = try await apiProivder.request(DTO.CheckDuplicatedIdResponse.self, target: apiTarget)
        return value.overlap
    }

    public func checkDuplicatedEmail(email: String) async throws -> Bool {
        let apiTarget = APITarget.User.checkDuplicatedEmail(DTO.CheckDuplicatedEmailRequest(email: email))
        let value = try await apiProivder.request(DTO.CheckDuplicatedEmailResponse.self, target: apiTarget)
        return value.overlap
    }

    public func userInfo() async throws -> UserInfo {
        let apiTarget = APITarget.User.userInfo
        let value = try await apiProivder.request(DTO.UserInfoResponse.self, target: apiTarget)
        return value.entity
    }
    
    public func changePassword(
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
        return try await apiProivder.request(target: apiTarget)
    }

    public func withDraw(
        id: String,
        password: String
    ) async throws -> Bool {
        let apiTarget = APITarget.User.withDraw(DTO.WithDrawUserRequest(loginId: id, password: password))
        return try await apiProivder.request(target: apiTarget)
    }
}
