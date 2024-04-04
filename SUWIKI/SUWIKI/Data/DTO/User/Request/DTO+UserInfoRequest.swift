//
//  DTO+UserInfoRequest.swift
//  SUWIKI
//
//  Created by 한지석 on 4/4/24.
//

import Foundation

extension DTO {
    struct UserInfoRequest: Encodable {
        let authorization: String
    }
}
