//
//  UserExamPost.swift
//  SUWIKI
//
//  Created by 한지석 on 4/5/24.
//

import Foundation

public struct UserExamPost: Identifiable, Hashable {
  public let id: Int
  public let name: String
  public let professor: String
  public let major: String // 개설학과
  public let selectedSemester: String
  public let semesterList: String // 개설학기
  public let examType: String // 중간, 기말
  public let sourceOfExam: String // 시험 유형
  public let difficulty: String // 난이도
  public let content: String
  
  public init(
    id: Int,
    name: String,
    professor: String,
    major: String,
    selectedSemester: String,
    semesterList: String,
    examType: String,
    sourceOfExam: String,
    difficulty: String,
    content: String
  ) {
    self.id = id
    self.name = name
    self.professor = professor
    self.major = major
    self.selectedSemester = selectedSemester
    self.semesterList = semesterList
    self.examType = examType
    self.sourceOfExam = sourceOfExam
    self.difficulty = difficulty
    self.content = content
  }
}
