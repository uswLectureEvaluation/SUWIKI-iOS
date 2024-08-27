//
//  SignUpInputType.swift
//  SUWIKI
//
//  Created by 한지석 on 4/10/24.
//

import Foundation

enum SignUpInputType: CaseIterable {
  case id
  case password
  case checkPassword
  case email
  
  var title: String {
    switch self {
    case .id:
      "아이디"
    case .password:
      "비밀번호"
    case .checkPassword:
      "비밀번호 확인"
    case .email:
      "이메일"
    }
  }
  
  var subtitle: String {
    switch self {
    case .id:
      "6~20자의 영문, 숫자 조합"
    case .password:
      "8~20자의 영문, 숫자, 특수문자 조합"
    case .checkPassword:
      "비밀번호 재입력"
    case .email:
      "@suwon.ac.kr"
    }
  }
  
  var warning: String {
    switch self {
    case .id:
      "6~20자의 영문/숫자 조합의 아이디를 입력해주세요."
    case .password:
      "8~20자 사이의 영문/숫자/특수문자 조합의 비밀번호를 입력해주세요."
    case .checkPassword:
      "비밀번호가 일치하지 않습니다."
    case .email:
      "올바른 형식의 수원대학교 이메일을 입력해주세요."
    }
  }
}
