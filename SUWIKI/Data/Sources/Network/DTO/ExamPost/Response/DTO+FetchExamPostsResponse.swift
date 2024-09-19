//
//  DTO+FetchExamPostsResponse.swift
//  SUWIKI
//
//  Created by 한지석 on 3/1/24.
//

import Foundation

extension DTO {
  public struct FetchExamPostsResponse: Decodable {
    /// 시험 정보 내용
    public let posts: [ExamPostResponse]
    /// 시험 정보를 읽을 수 있는가?
    public let canRead: Bool
    /// 유저가 작성했는지 여부
    public let written: Bool
    /// 시험 정보가 존재하는지 판별
    public let examDataExist: Bool
    
    public init(
      posts: [ExamPostResponse],
      canRead: Bool,
      written: Bool, 
      examDataExist: Bool
    ) {
      self.posts = posts
      self.canRead = canRead
      self.written = written
      self.examDataExist = examDataExist
    }
    
    enum CodingKeys: String, CodingKey {
      case posts = "data"
      case canRead
      case written
      case examDataExist
    }
  }
}
