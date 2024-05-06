//
//  DTO+CheckIdRequest.swift
//  SUWIKI
//
//  Created by 한지석 on 2/3/24.
//

import Foundation

extension DTO {
    public struct CheckIdRequest: Encodable {
        /// 아이디 중복 확인
        public let loginId: String

        public init(loginId: String) {
            self.loginId = loginId
        }
    }
}
