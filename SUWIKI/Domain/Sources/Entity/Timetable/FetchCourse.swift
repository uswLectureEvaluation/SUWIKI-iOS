//
//  FirebaseCourse.swift
//  SUWIKI
//
//  Created by 한지석 on 2023/06/14.
//

import Foundation

public struct FetchCourse {
  public var classNum: String
  public var classification: String
  public var courseDay: String
  public var courseName: String
  public var credit: Int
  public var startTime: String
  public var endTime: String
  public var major: String
  public var num: Int
  public var professor: String
  public var roomName: String
  
  public init(
    classNum: String,
    classification: String,
    courseDay: String,
    courseName: String,
    credit: Int,
    startTime: String,
    endTime: String,
    major: String,
    num: Int,
    professor: String,
    roomName: String
  ) {
    self.classNum = classNum
    self.classification = classification
    self.courseDay = courseDay
    self.courseName = courseName
    self.credit = credit
    self.startTime = startTime
    self.endTime = endTime
    self.major = major
    self.num = num
    self.professor = professor
    self.roomName = roomName
  }
}
