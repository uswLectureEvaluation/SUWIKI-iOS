//
//  DTO+FindPasswordRequest.swift
//  SUWIKI
//
//  Created by 한지석 on 4/10/24.
//

import Foundation

extension DTO {
    public struct FindPasswordRequest: Encodable {
        public let loginId: String
        public let email: String

        public init(
            loginId: String,
            email: String
        ) {
            self.loginId = loginId
            self.email = email
        }
    }
}
