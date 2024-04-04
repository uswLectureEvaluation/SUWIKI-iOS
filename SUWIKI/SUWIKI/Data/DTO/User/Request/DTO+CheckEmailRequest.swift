//
//  DTO+CheckEmailRequest.swift
//  SUWIKI
//
//  Created by 한지석 on 2/3/24.
//

import Foundation

extension DTO {
    struct CheckEmailRequest: Encodable {
        /// 학교 이메일
        let email: String
    }
}
