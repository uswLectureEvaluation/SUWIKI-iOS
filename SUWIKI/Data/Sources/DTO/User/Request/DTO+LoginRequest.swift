//
//  DTO+LoginRequest.swift
//  SUWIKI
//
//  Created by 한지석 on 2/2/24.
//

import Foundation

extension DTO {
    public struct LoginRequest: Encodable {
        /// 유저 아이디
        public let loginId: String
        /// PWD
        public let password: String

        public init(
            loginId: String,
            password: String
        ) {
            self.loginId = loginId
            self.password = password
        }
    }
}
