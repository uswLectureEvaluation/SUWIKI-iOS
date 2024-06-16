//
//  UserInfo.swift
//  SUWIKI
//
//  Created by 한지석 on 4/4/24.
//

import Foundation

public struct UserInfo {
  public let id: String
  public let email: String
  public let point: Int
  public let writtenEvaluationPosts: Int
  public let writtenExamPosts: Int
  public let purchasedExamPosts: Int
  
  public init(
    id: String,
    email: String,
    point: Int,
    writtenEvaluationPosts: Int,
    writtenExamPosts: Int,
    purchasedExamPosts: Int
  ) {
    self.id = id
    self.email = email
    self.point = point
    self.writtenEvaluationPosts = writtenEvaluationPosts
    self.writtenExamPosts = writtenExamPosts
    self.purchasedExamPosts = purchasedExamPosts
  }
}
