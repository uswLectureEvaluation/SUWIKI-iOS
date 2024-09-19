//
//  DTO+FetchUserExamPostsResponse.swift
//  SUWIKI
//
//  Created by 한지석 on 4/5/24.
//

import Foundation

import Domain

extension DTO {
  public struct FetchUserExamPostsResponse: Decodable {
    public let posts: [UserExamPostResponse]
    public let statusCode: Int?
    public let message: String?
    
    public init(
      posts: [UserExamPostResponse], 
      statusCode: Int?,
      message: String?
    ) {
      self.posts = posts
      self.statusCode = statusCode
      self.message = message
    }
    
    enum CodingKeys: String, CodingKey {
      case posts = "data"
      case statusCode
      case message
    }
  }
}

extension DTO.FetchUserExamPostsResponse {
  public struct UserExamPostResponse: Decodable {
    public let id: Int
    public let lectureName: String
    public let professor: String
    public let majorType: String
    public let selectedSemester: String
    public let semesterList: String
    public let examType: String
    public let examInfo: String
    public let examDifficulty: String
    public let content: String
    
    public init(
      id: Int,
      lectureName: String,
      professor: String,
      majorType: String,
      selectedSemester: String,
      semesterList: String,
      examType: String,
      examInfo: String,
      examDifficulty: String,
      content: String) {
        self.id = id
        self.lectureName = lectureName
        self.professor = professor
        self.majorType = majorType
        self.selectedSemester = selectedSemester
        self.semesterList = semesterList
        self.examType = examType
        self.examInfo = examInfo
        self.examDifficulty = examDifficulty
        self.content = content
      }
    
    var entity: UserExamPost {
      UserExamPost(id: id,
                   name: lectureName,
                   professor: professor,
                   major: majorType,
                   selectedSemester: selectedSemester,
                   semesterList: semesterList,
                   examType: examType,
                   sourceOfExam: examInfo,
                   difficulty: examDifficulty,
                   content: content)
    }
  }
}
