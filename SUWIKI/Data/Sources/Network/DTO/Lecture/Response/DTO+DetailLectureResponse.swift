//
//  DTO+DetailLectureResponse.swift
//  SUWIKI
//
//  Created by 한지석 on 2/5/24.
//

import Foundation

import Domain

extension DTO {
  public struct DetailLectureResponse: Codable {
    /// 강의 ID
    public let id: Int
    /// 해당 강의 년도 + 학기 -> "2021-1,2022-1"
    public let semesterList: String
    /// 교수명
    public let professor: String
    /// 개설 학과
    public let majorType: String
    /// 이수 구분
    public let lectureType: String
    /// 강의명
    public let lectureName: String
    /// 강의평가 평균 지수
    public let lectureTotalAvg: Float
    /// 강의평가 만족도 지수
    public let lectureSatisfactionAvg: Float
    /// 강의평가 꿀강 지수
    public let lectureHoneyAvg: Float
    /// 강의평가 배움 지수
    public let lectureLearningAvg: Float
    /// 강의평가 팀플 지수
    public let lectureTeamAvg: Float
    /// 강의평가 난이도 지수
    public let lectureDifficultyAvg: Float
    /// 강의평가 과제 지수
    public let lectureHomeworkAvg: Float
    
    public init(
      id: Int,
      semesterList: String,
      professor: String,
      majorType: String,
      lectureType: String,
      lectureName: String,
      lectureTotalAvg: Float,
      lectureSatisfactionAvg: Float,
      lectureHoneyAvg: Float,
      lectureLearningAvg: Float,
      lectureTeamAvg: Float,
      lectureDifficultyAvg: Float,
      lectureHomeworkAvg: Float
    ) {
      self.id = id
      self.semesterList = semesterList
      self.professor = professor
      self.majorType = majorType
      self.lectureType = lectureType
      self.lectureName = lectureName
      self.lectureTotalAvg = lectureTotalAvg
      self.lectureSatisfactionAvg = lectureSatisfactionAvg
      self.lectureHoneyAvg = lectureHoneyAvg
      self.lectureLearningAvg = lectureLearningAvg
      self.lectureTeamAvg = lectureTeamAvg
      self.lectureDifficultyAvg = lectureDifficultyAvg
      self.lectureHomeworkAvg = lectureHomeworkAvg
    }
  }
}

extension DTO.DetailLectureResponse {
  var entity: DetailLecture {
    DetailLecture(
      id: id,
      name: lectureName,
      major: majorType,
      professor: professor,
      semester: semesterList,
      lectureType: lectureType,
      lectureTotalAvg: Double(lectureTotalAvg),
      lectureSatisfactionAvg: Double(lectureSatisfactionAvg),
      lectureHoneyAvg: Double(lectureHoneyAvg),
      lectureLearningAvg: Double(lectureLearningAvg),
      lectureDifficultyAvg: Int(lectureDifficultyAvg),
      lectureTeamAvg: Int(lectureTeamAvg),
      lectureHomeworkAvg: Int(lectureHomeworkAvg)
    )
  }
}

//
//extension DTO.LectureResponse {
//    var entity: Lecture {
//        Lecture(id: id,
//                name: lectureName,
//                major: majorType,
//                professor: professor,
//                lectureType: lectureType,
//                lectureTotalAvg: Double(lectureTotalAvg))
//    }
//}
