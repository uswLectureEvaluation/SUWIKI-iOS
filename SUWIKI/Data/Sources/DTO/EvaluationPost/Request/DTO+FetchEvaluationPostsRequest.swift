//
//  DTO+FetchEvaluatePostsRequest.swift
//  SUWIKI
//
//  Created by 한지석 on 2/8/24.
//

import Foundation

extension DTO {
  public struct FetchEvaluationPostRequest: Encodable {
    /// 강의 ID
    public let lectureId: Int
    /// 페이지(1...)
    public let page: Int
    
    public init(
      lectureId: Int,
      page: Int
    ) {
      self.lectureId = lectureId
      self.page = page
    }
  }
}
