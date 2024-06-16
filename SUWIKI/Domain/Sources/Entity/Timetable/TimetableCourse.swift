//
//  CourseList.swift
//  SUWIKI
//
//  Created by 한지석 on 2023/06/10.
//

import Foundation

public struct TimetableCourse {
  public var courseId: String
  public var courseName: String
  public var roomName: String
  public var professor: String
  public var courseDay: Int
  public var startTime: String
  public var endTime: String
  public var timetableColor: Int
  
  public init(
    courseId: String,
    courseName: String,
    roomName: String,
    professor: String,
    courseDay: Int,
    startTime: String,
    endTime: String,
    timetableColor: Int
  ) {
    self.courseId = courseId
    self.courseName = courseName
    self.roomName = roomName
    self.professor = professor
    self.courseDay = courseDay
    self.startTime = startTime
    self.endTime = endTime
    self.timetableColor = timetableColor
  }
}
