//
//  DTO+ResetPasswordRequest.swift
//  SUWIKI
//
//  Created by 한지석 on 4/8/24.
//

import Foundation

extension DTO {
    struct ChangePasswordRequest: Encodable {
        let prePassword: String
        let newPassword: String
    }
}
