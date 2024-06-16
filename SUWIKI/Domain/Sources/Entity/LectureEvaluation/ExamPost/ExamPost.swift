//
//  ExamPost.swift
//  SUWIKI
//
//  Created by 한지석 on 3/1/24.
//

import Foundation

public struct ExamPost: Identifiable {
  public let id: Int
  public let semester: String
  public let examType: String
  public let sourceOfExam: String
  public let difficulty: String
  public let content: String
  
  public init(
    id: Int,
    semester: String,
    examType: String,
    sourceOfExam: String,
    difficulty: String,
    content: String
  ) {
    self.id = id
    self.semester = semester
    self.examType = examType
    self.sourceOfExam = sourceOfExam
    self.difficulty = difficulty
    self.content = content
  }
}

extension ExamPost {
  static public let MockData = ExamPost(id: 34500435098543908,
                                        semester: "1233-3",
                                        examType: "1233-3",
                                        sourceOfExam: "몰라, 너가, 알아내",
                                        difficulty: "개어려움~",
                                        content: 
"""
ABCDEFG, HIGJEOF< werojwerpfds, ewfnowwfpia!dsafmleffe\n 
jeABCDEFG, HIGJEOF< werojwerpfds, ewfnowwfpia!dsafmleffe\n wefpojwopjfewjfpwfjew
""")
}
