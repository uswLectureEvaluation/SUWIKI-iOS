//
//  DTO+AllEvaluatePostsResponse.swift
//  SUWIKI
//
//  Created by 한지석 on 2/27/24.
//

import Foundation

extension DTO {
  public struct FetchEvaluationPostsResponse: Decodable {
    public let posts: [DTO.EvaluationPostResponse]
    public let written: Bool
    
    public init(
      posts: [DTO.EvaluationPostResponse],
      written: Bool
    ) {
      self.posts = posts
      self.written = written
    }
    
    enum CodingKeys: String, CodingKey {
      case posts = "data"
      case written
    }
  }
}
