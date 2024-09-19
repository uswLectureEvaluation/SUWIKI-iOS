//
//  APITarget+User.swift
//  SUWIKI
//
//  Created by 한지석 on 2/2/24.
//

import Foundation

import Network

public extension APITarget {
  enum User: TargetType {
    case login(DTO.LoginRequest)
    case join(DTO.JoinRequest)
    case findId(DTO.FindIdRequest)
    case findPassword(DTO.FindPasswordRequest)
    case checkDuplicatedId(DTO.CheckDuplicatedIdRequest)
    case checkDuplicatedEmail(DTO.CheckDuplicatedEmailRequest)
    case refresh(DTO.RefreshRequest)
    case userInfo
    case changePassword(DTO.ChangePasswordRequest)
    case withDraw(DTO.WithDrawUserRequest)
  }
}

public extension APITarget.User {
  var targetURL: URL {
    URL(string: APITarget.baseURL + "user")!
  }
  
  var method: NetworkHTTPMethod {
    switch self {
    case .login:
      return .post
    case .join:
      return .post
    case .findId:
      return .post
    case .findPassword:
      return .post
    case .checkDuplicatedId:
      return .post
    case .checkDuplicatedEmail:
      return .post
    case .refresh:
      return .post
    case .userInfo:
      return .get
    case .changePassword:
      return .post
    case .withDraw:
      return .post
    }
  }
  
  var path: String {
    switch self {
    case .login:
      return "/login"
    case .join:
      return "/join"
    case .findId:
      return "/find-id"
    case .findPassword:
      return "/find-pw"
    case .checkDuplicatedId:
      return "/check-id"
    case .checkDuplicatedEmail:
      return "/check-email"
    case .refresh:
      return "/refresh"
    case .userInfo:
      return "/my-page"
    case .changePassword:
      return "/reset-pw"
    case .withDraw:
      return "/quit"
    }
  }
  
  var parameters: RequestParameter {
    switch self {
    case let .login(loginRequest):
      return .body(loginRequest)
    case let .join(joinRequest):
      return .body(joinRequest)
    case let .findId(findIdRequest):
      return .body(findIdRequest)
    case let .findPassword(findPasswordRequest):
      return .body(findPasswordRequest)
    case let .checkDuplicatedId(checkDuplicatedIdRequest):
      return .body(checkDuplicatedIdRequest)
    case let .checkDuplicatedEmail(checkDuplicatedEmailRequest):
      return .body(checkDuplicatedEmailRequest)
    case .refresh:
      return .plain
    case .userInfo:
      return .plain
    case let .changePassword(changePasswordRequest):
      return .body(changePasswordRequest)
    case let .withDraw(withDrawRequest):
      return .body(withDrawRequest)
    }
  }
}
