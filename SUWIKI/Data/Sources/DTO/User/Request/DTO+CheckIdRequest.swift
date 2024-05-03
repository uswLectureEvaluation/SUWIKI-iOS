//
//  DTO+CheckIdRequest.swift
//  SUWIKI
//
//  Created by 한지석 on 2/3/24.
//

import Foundation

extension DTO {
    struct CheckIdRequest: Encodable {
        /// 아이디 중복 확인
        let loginId: String
    }
}
