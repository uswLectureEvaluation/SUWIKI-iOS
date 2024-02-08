//
//  DTO+JoinRequest.swift
//  SUWIKI
//
//  Created by 한지석 on 2/3/24.
//

import Foundation

extension DTO {
    struct JoinRequest: Encodable {
        /// 유저 아이디
        let loginId: String
        /// 패스워드
        let password: String
        /// 회원가입 학교 이메일
        let email: String
    }
}
