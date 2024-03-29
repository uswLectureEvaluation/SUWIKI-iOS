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
        case join(DTO.JoinRequest)
        case checkId(DTO.CheckIdRequest)
        case checkEmail(DTO.CheckEmailRequest)
        case refresh(DTO.RefreshRequest)
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
        case .join:
            return .post
        case .checkId:
            return .post
        case .checkEmail:
            return .post
        case .refresh:
            return .post
        }
    }

    var path: String {
        switch self {
        case .login:
            return "/login"
        case .join:
            return "/join"
        case .checkId:
            return "/check-id"
        case .checkEmail:
            return "/check-email"
        case .refresh:
            return "/refresh"
        }
    }

//    var headers: [String: String]? {
//        switch self {
//        case let .refresh(refreshRequest):
//            return [
//                "Content-Type": "application/json",
//                "Authorization": "\(refreshRequest.authorization)"
//            ]
//        default:
//            return ["Content-Type": "application/json"]
//        }
//    }

    var parameters: RequestParameter {
        switch self {
        case let .login(loginRequest):
            return .body(loginRequest)
        case let .join(joinRequest):
            return .body(joinRequest)
        case let .checkId(checkIdRequest):
            return .body(checkIdRequest)
        case let .checkEmail(checkEmailRequest):
            return .body(checkEmailRequest)
        case .refresh:
            return .plain
        }
    }
}
