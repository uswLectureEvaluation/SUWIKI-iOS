//
//  DTO+RefreshResponse.swift
//  SUWIKI
//
//  Created by 한지석 on 2/27/24.
//

import Foundation

extension DTO {
    struct RefreshResponse: Decodable {
        let refreshToken: String
        let accessToken: String
    }
}
