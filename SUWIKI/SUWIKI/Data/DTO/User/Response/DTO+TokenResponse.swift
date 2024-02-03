//
//  DTO+TokenResponse.swift
//  SUWIKI
//
//  Created by 한지석 on 2/2/24.
//

import Foundation

extension DTO {
    struct TokenResponse: Codable {
        /// 액세스 토큰
        let AccessToken: String
        /// 리프레쉬 토큰
        let RefreshToken: String
    }
}
