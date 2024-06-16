//
//  DTO+FetchUserEvaluationPosts.swift
//  SUWIKI
//
//  Created by 한지석 on 4/4/24.
//

import Foundation

import Domain

extension DTO {
  public struct FetchUserEvaluationPostsResponse: Decodable {
    public let posts: [UserEvaluationPostResponse]
    public let statusCode: Int?
    public let message: String?
    
    enum CodingKeys: String, CodingKey {
      case posts = "data"
      case statusCode
      case message
    }
  }
}

extension DTO.FetchUserEvaluationPostsResponse {
  public struct UserEvaluationPostResponse: Decodable {
    public let id: Int
    public let lectureName: String
    public let professor: String
    public let majorType: String
    public let selectedSemester: String
    public let semesterList: String
    public let totalAvg: Double
    public let satisfaction: Double
    public let learning: Double
    public let honey: Double
    public let team: Int
    public let difficulty: Int
    public let homework: Int
    public let content: String
    
    public init(
      id: Int,
      lectureName: String,
      professor: String,
      majorType: String,
      selectedSemester: String,
      semesterList: String,
      totalAvg: Double,
      satisfaction: Double,
      learning: Double,
      honey: Double,
      team: Int,
      difficulty: Int,
      homework: Int,
      content: String
    ) {
      self.id = id
      self.lectureName = lectureName
      self.professor = professor
      self.majorType = majorType
      self.selectedSemester = selectedSemester
      self.semesterList = semesterList
      self.totalAvg = totalAvg
      self.satisfaction = satisfaction
      self.learning = learning
      self.honey = honey
      self.team = team
      self.difficulty = difficulty
      self.homework = homework
      self.content = content
    }
    
    var entity: UserEvaluationPost {
      UserEvaluationPost(id: id,
                         name: lectureName,
                         professor: professor,
                         selectedSemester: selectedSemester,
                         semester: semesterList,
                         lectureTotalAvg: totalAvg,
                         lectureSatisfactionAvg: satisfaction,
                         lectureHoneyAvg: honey,
                         lectureLearningAvg: learning,
                         lectureDifficultyAvg: difficulty,
                         lectureTeamAvg: team,
                         lectureHomeworkAvg: homework,
                         content: content)
    }
  }
}
