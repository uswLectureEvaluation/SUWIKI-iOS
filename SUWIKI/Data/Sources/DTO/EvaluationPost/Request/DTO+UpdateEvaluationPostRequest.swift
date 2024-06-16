//
//  DTO+ModifyEvaluationPostRequest.swift
//  SUWIKI
//
//  Created by 한지석 on 4/5/24.
//

import Foundation

extension DTO {
  public struct UpdateEvaluationPostRequest: Encodable {
    public let lectureInfo: LectureInfo
    public let post: Post
    
    public init(
      lectureInfo: LectureInfo,
      post: Post
    ) {
      self.lectureInfo = lectureInfo
      self.post = post
    }
  }
}

extension DTO.UpdateEvaluationPostRequest {
  public struct LectureInfo: Encodable {
    public let evaluateIdx: Int
    
    public init(evaluateIdx: Int) {
      self.evaluateIdx = evaluateIdx
    }
  }
  
  public struct Post: Encodable {
    public let selectedSemester: String
    public let satisfaction: Double
    public let learning: Double
    public let honey: Double
    public let team: Int
    public let difficulty: Int
    public let homework: Int
    public let content: String
    
    public init(
      selectedSemester: String,
      satisfaction: Double,
      learning: Double,
      honey: Double,
      team: Int,
      difficulty: Int,
      homework: Int,
      content: String
    ) {
      self.selectedSemester = selectedSemester
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
