//
//  AddCourseViewModel.swift
//  SUWIKI
//
//  Created by 한지석 on 2023/08/22.
//

import Foundation

import Domain

final class AddCourseViewModel {

  private let addCourseManager = AddCourseManager()
  @Published var timetableColorNumber = Int.random(in: 0...20)
  @Published var fetchCourse: FetchCourse
  
  init(fetchCourse: FetchCourse) {
    self.fetchCourse = fetchCourse
  }
  
  func changeTimetableColor() {
    var changeNumber = Int.random(in: 0...20)
    while changeNumber == timetableColorNumber {
      changeNumber = Int.random(in: 0...20)
    }
    timetableColorNumber = changeNumber
  }
  
  func saveCourse() async throws -> Bool {
    var isDuplicated = false
    let course = TimetableCourse(
      courseId: UUID().uuidString,
      courseName: fetchCourse.courseName,
      roomName: fetchCourse.roomName,
      professor: fetchCourse.professor,
      courseDay: dayToInt(courseDay: fetchCourse.courseDay),
      startTime: fetchCourse.startTime,
      endTime: fetchCourse.endTime,
      timetableColor: timetableColorNumber
    )
    if fetchCourse.courseName.contains("이러닝") || fetchCourse.courseName.contains("온라인") {
      isDuplicated = try await addCourseManager.saveCourse(
        newCourse: course,
        duplicateCase: .eLearning
      )
    } else if fetchCourse.roomName.split(separator: " ").count > 1 {
      // 1. 음악109(화1,2 수3,4)
      isDuplicated = try await addCourseManager.saveCourse(
        newCourse: course,
        duplicateCase: .differentTime
      )
    } else if fetchCourse.roomName.split(separator: "),").count > 1 {
      // 2. 음악109(화1,2),음악110(수1,2)
      isDuplicated = try await addCourseManager.saveCourse(
        newCourse: course,
        duplicateCase: .differentPlace
      )
    } else {
      isDuplicated = try await addCourseManager.saveCourse(
        newCourse: course,
        duplicateCase: .normal
      )
    }
    return isDuplicated
  }
  
  func dayToInt(courseDay: String) -> Int {
    var dayToString = 0
    switch courseDay {
    case "월":
      dayToString = 1
    case "화":
      dayToString = 2
    case "수":
      dayToString = 3
    case "목":
      dayToString = 4
    case "금":
      dayToString = 5
    default:
      break
    }
    return dayToString
  }
}
