//
//  DTO+JoinRequest.swift
//  SUWIKI
//
//  Created by 한지석 on 2/3/24.
//

import Foundation

extension DTO {
    public struct JoinRequest: Encodable {
        /// 유저 아이디
        public let loginId: String
        /// 패스워드
        public let password: String
        /// 회원가입 학교 이메일
        public let email: String

        public init(
            loginId: String,
            password: String,
            email: String
        ) {
            self.loginId = loginId
            self.password = password
            self.email = email
        }
    }
}
