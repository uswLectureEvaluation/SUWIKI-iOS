//
//  DefaultUserRepository.swift
//  SUWIKI
//
//  Created by 한지석 on 2/4/24.
//

import Foundation

final class DefaultUserRepository: UserRepository {

    func login(
        id: String,
        password: String
    ) async throws -> SignIn {
        let target = APITarget.User.login(
            DTO.LoginRequest(
                loginId: id,
                password: password
            )
        )
        let dtoTokens = try await APIProvider.request(
            DTO.TokenResponse.self,
            target: target)
        return dtoTokens.entity
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
}
