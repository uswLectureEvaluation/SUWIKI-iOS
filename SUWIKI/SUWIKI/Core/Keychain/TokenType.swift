//
//  TokenType.swift
//  SUWIKI
//
//  Created by 한지석 on 2/3/24.
//

import Foundation

enum TokenType {
    case AccessToken
    case RefreshToken

    var account: String {
        switch self {
        case .AccessToken:
            "accessToken"
        case .RefreshToken:
            "refreshToken"
        }
    }
}
