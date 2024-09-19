//
//  DTO+FetchEvaluatePostsResponse.swift
//  SUWIKI
//
//  Created by 한지석 on 2/8/24.
//

import Foundation

import Domain

extension DTO {
  public struct EvaluationPostResponse: Decodable {
    /// 글 ID
    public let id: Int
    /// 수강 학기
    public let selectedSemester: String
    /// 총 평균
    public let totalAvg: Float
    /// 만족도
    public let satisfaction: Float
    /// 배움지수
    public let learning: Float
    /// 꿀강 지수
    public let honey: Float
    /// 조별모임 유무(없음 == 0, 있음 == 1)
    public let team: Int
    /// 학점 잘주는가?(잘줌 == 0, 보통 == 1, 까다로움 == 2)
    public let difficulty: Int
    /// 과제양(없음 == 0, 보통 == 1, 많음 == 2)
    public let homework: Int
    /// 작성글
    public let content: String

    public init(
      id: Int,
      selectedSemester: String,
      totalAvg: Float,
      satisfaction: Float,
      learning: Float,
      honey: Float,
      team: Int,
      difficulty: Int,
      homework: Int,
      content: String
    ) {
      self.id = id
      self.selectedSemester = selectedSemester
      self.totalAvg = totalAvg
      self.satisfaction = satisfaction
      self.learning = learning
      self.honey = honey
      self.team = team
      self.difficulty = difficulty
      self.homework = homework
      self.content = content
    }
  }
}

extension DTO.EvaluationPostResponse {
  var entity: EvaluationPost {
    EvaluationPost(
      id: id,
      selectedSemester: selectedSemester,
      totalAvarage: Double(totalAvg),
      content: content
    )
  }
}
