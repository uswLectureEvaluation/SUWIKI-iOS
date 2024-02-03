//
//  DTO+LoginRequest.swift
//  SUWIKI
//
//  Created by 한지석 on 2/2/24.
//

import Foundation

extension DTO {
    struct LoginRequest: Encodable {
        /// ID
        let loginId: String
        /// PWD
        let password: String
    }
}
