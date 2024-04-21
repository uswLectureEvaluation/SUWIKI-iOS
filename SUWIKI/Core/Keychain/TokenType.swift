//
//  File.swift
//  
//
//  Created by 한지석 on 4/21/24.
//

import Foundation

public enum TokenType {
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
