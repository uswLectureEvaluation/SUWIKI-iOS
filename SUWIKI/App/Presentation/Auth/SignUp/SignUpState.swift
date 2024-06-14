//
//  SignUpState.swift
//  SUWIKI
//
//  Created by 한지석 on 4/10/24.
//

import Foundation

enum SignUpState {
  case idAndPassword
  case email
  case success
  
  var title: String {
    switch self {
    case .idAndPassword:
      "회원가입"
    case .email:
      "학교 이메일을 입력하세요."
    case .success:
      "메일을 확인하세요!"
    }
  }
}
