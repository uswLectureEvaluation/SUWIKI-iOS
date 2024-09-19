//
//  DTO+WriteExamPostRequest.swift
//  SUWIKI
//
//  Created by 한지석 on 3/29/24.
//

import Foundation

extension DTO {
  public struct WriteExamPostRequest: Encodable {
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

extension DTO.WriteExamPostRequest {
  public struct LectureInfo: Encodable {
    public let lectureId: Int
    
    public init(lectureId: Int) {
      self.lectureId = lectureId
    }
  }
  public struct Post: Encodable {
    /// 강의명
    public let lectureName: String
    /// 교수
    public let professor: String
    /// 선택학기
    public let selectedSemester: String
    /// 교재, 피피티 등
    public let examInfo: String
    /// 중간고사 - 기말고사
    public let examType: String
    /// 쉬움, 보통, 어려움
    public let examDifficulty: String
    /// 유저가 작성한 내용
    public let content: String
    
    public init(
      lectureName: String,
      professor: String,
      selectedSemester: String,
      examInfo: String,
      examType: String,
      examDifficulty: String,
      content: String
    ) {
      self.lectureName = lectureName
      self.professor = professor
      self.selectedSemester = selectedSemester
      self.examInfo = examInfo
      self.examType = examType
      self.examDifficulty = examDifficulty
      self.content = content
    }
  }
}
