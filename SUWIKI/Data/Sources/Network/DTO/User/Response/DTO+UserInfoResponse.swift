//
//  DTO+UserInfoResponse.swift
//  SUWIKI
//
//  Created by 한지석 on 4/4/24.
//

import Foundation

import Domain

extension DTO {
  public struct UserInfoResponse: Decodable {
    public let loginId: String
    public let email: String
    public let point: Int
    public let writtenEvaluation: Int
    public let writtenExam: Int
    public let viewExam: Int
    
    public init(
      loginId: String,
      email: String,
      point: Int,
      writtenEvaluation: Int,
      writtenExam: Int,
      viewExam: Int
    ) {
      self.loginId = loginId
      self.email = email
      self.point = point
      self.writtenEvaluation = writtenEvaluation
      self.writtenExam = writtenExam
      self.viewExam = viewExam
    }
  }
}

extension DTO.UserInfoResponse {
  var entity: UserInfo {
    UserInfo(
      id: loginId,
      email: email,
      point: point,
      writtenEvaluationPosts: writtenEvaluation,
      writtenExamPosts: writtenExam,
      purchasedExamPosts: viewExam
    )
  }
}
