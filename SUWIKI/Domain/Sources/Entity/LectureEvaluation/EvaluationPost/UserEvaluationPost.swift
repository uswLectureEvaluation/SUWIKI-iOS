//
//  UserEvaluationPost.swift
//  SUWIKI
//
//  Created by 한지석 on 4/4/24.
//

import Foundation

public struct UserEvaluationPost: Identifiable, Hashable {
  /// 강의평가 ID
  public let id: Int
  /// 강의 이름
  public let name: String
  /// 교수
  public let professor: String
  /// 유저 선택 학기
  public let selectedSemester: String
  /// 개설학기
  public let semester: String
  /// 강의평가 종합 지수
  public let lectureTotalAvg: Double
  /// 강의 평가 만족도 지수
  public let lectureSatisfactionAvg: Double
  /// 강의 평가 꿀강 지수
  public let lectureHoneyAvg: Double
  /// 강의 평가 배움 지수
  public let lectureLearningAvg: Double
  /// 학점 지수
  public let lectureDifficultyAvg: Int
  /// 팀플 지수
  public let lectureTeamAvg: Int
  /// 과제 지수
  public let lectureHomeworkAvg: Int
  /// 강의평가 내용
  public let content: String
  
  public init(
    id: Int,
    name: String,
    professor: String,
    selectedSemester: String,
    semester: String,
    lectureTotalAvg: Double,
    lectureSatisfactionAvg: Double,
    lectureHoneyAvg: Double,
    lectureLearningAvg: Double,
    lectureDifficultyAvg: Int,
    lectureTeamAvg: Int,
    lectureHomeworkAvg: Int,
    content: String
  ) {
    self.id = id
    self.name = name
    self.professor = professor
    self.selectedSemester = selectedSemester
    self.semester = semester
    self.lectureTotalAvg = lectureTotalAvg
    self.lectureSatisfactionAvg = lectureSatisfactionAvg
    self.lectureHoneyAvg = lectureHoneyAvg
    self.lectureLearningAvg = lectureLearningAvg
    self.lectureDifficultyAvg = lectureDifficultyAvg
    self.lectureTeamAvg = lectureTeamAvg
    self.lectureHomeworkAvg = lectureHomeworkAvg
    self.content = content
  }
}
