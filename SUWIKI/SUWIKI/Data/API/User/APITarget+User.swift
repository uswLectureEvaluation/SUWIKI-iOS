//
//  APITarget+User.swift
//  SUWIKI
//
//  Created by 한지석 on 2/2/24.
//

import Foundation

import Alamofire

extension APITarget {
    enum User: TargetType {
        case login(DTO.LoginRequest)
    }
}

extension APITarget.User {
    var targetURL: URL {
        URL(string: APITarget.baseURL + "user")!
    }

    var method: Alamofire.HTTPMethod {
        switch self {
        case .login:
            return .post
        }
    }

    var path: String {
        switch self {
        case .login:
            return "/login"
        }
    }

    var parameters: RequestParameter {
        switch self {
        case let .login(loginRequest):
            return .body(loginRequest)
        }
    }
}
