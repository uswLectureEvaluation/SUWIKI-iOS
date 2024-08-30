//
//  AddCourseManager.swift
//  SUWIKI
//
//  Created by 한지석 on 2023/06/29.
//

import Foundation

import DIContainer
import Domain

enum DuplicateCase {
  case eLearning
  case normal
  case differentTime
  case differentPlace
}

final class AddCourseManager {
  @Inject var fetchCourseUseCase: FetchCoursesUseCase
  @Inject var saveCourseUseCase: SaveCourseUseCase
  @Inject var fetchELearningUseCase: FetchELearningUseCase

  func saveCourse(
    newCourse: TimetableCourse,
    duplicateCase: DuplicateCase
  ) async throws -> Bool {
    guard let id = UserDefaults.shared.value(forKey: "id") as? String,
          let timetableCourse = fetchCourseUseCase.execute(id: id)
    else { return false }

    var course: [TimetableCourse] = []
    switch duplicateCase {
    case .eLearning:
      course = [createELearningCourse(id: id, course: newCourse)]
    case .normal:
      course = [createNormalCourse(newCourse: newCourse)]
    case .differentTime:
      course = createDifferentTimeCourse(course: newCourse)
    case .differentPlace:
      course = createDifferentPlaceCourse(course: newCourse)
    }

    let isDuplicated = isCourseDuplicated(existingCourses: timetableCourse, courses: course)

    if !isDuplicated {
      for i in 0..<course.count {
        saveCourseUseCase.execute(id: id, course: course[i])
      }
    }
    return isDuplicated
  }

  private func isCourseDuplicated(
    existingCourses: [TimetableCourse],
    courses: [TimetableCourse]
  ) -> Bool {
    for existingCourse in existingCourses {
      for newCourse in courses {
        if isTimeDuplicated(
          existingCourse: existingCourse,
          newCourse: newCourse
        ) {
          return true
        }
      }
    }
    return false
  }

  func createELearningCourse(
    id: String,
    course: TimetableCourse
  ) -> TimetableCourse {
    let eStart = ["9:30", "11:30", "13:30"]
    let eEnd = ["11:20", "13:20", "15:20"]
    let eLearningCourses = fetchELearningUseCase.execute(id: id)
    let nums = eLearningCourses.count < 3 ? eLearningCourses.count : 0
    let eLearning = TimetableCourse(
      courseId: course.courseId,
      courseName: course.courseName,
      roomName: course.roomName,
      professor: course.professor,
      courseDay: 6,
      startTime: eStart[nums],
      endTime: eEnd[nums],
      timetableColor: course.timetableColor
    )
    return eLearning
  }

  private func createNormalCourse(newCourse: TimetableCourse) -> TimetableCourse {
    let roomName = newCourse.roomName.split(separator: "(").map { String($0) }[0]
    return TimetableCourse(
      courseId: newCourse.courseId,
      courseName: newCourse.courseName,
      roomName: roomName,
      professor: newCourse.professor,
      courseDay: newCourse.courseDay,
      startTime: newCourse.startTime,
      endTime: newCourse.endTime,
      timetableColor: newCourse.timetableColor
    )
  }

  func createDifferentTimeCourse(course: TimetableCourse) -> [TimetableCourse] {
    var timeTableCourse: [TimetableCourse] = []
    let components = course.roomName.split(separator: " ")
    let roomName = course.roomName.split(separator: "(").map { String($0)} [0]
    let firstIndex = components[0].firstIndex(of: "(")
    let firstDayIndex = components[0].index(after: firstIndex!)
    let firstDay = String(components[0][firstDayIndex])
    let firstTime = components[0].split(separator: firstDay)[1].split(separator: ",")
    let firstStartTime = String(firstTime[0])
    let firstEndTime = String(firstTime[firstTime.count - 1])
    timeTableCourse.append(
      TimetableCourse(
        courseId: UUID().uuidString,
        courseName: course.courseName,
        roomName: roomName,
        professor: course.professor,
        courseDay: dayToInt(courseDay: firstDay),
        startTime: startTimeToString(start: firstStartTime),
        endTime: endTimeToString(end: firstEndTime),
        timetableColor: course.timetableColor
      )
    )
    if components.count == 3 {
      var secondDay = ""
      if let day = components[1].first {
        secondDay = String(day)
      }
      let secondTime = components[1].dropFirst().split(separator: ",")
      let secondStartTime = String(secondTime[0])
      let secondEndTime = String(secondTime[secondTime.count - 1])
      timeTableCourse.append(
        TimetableCourse(
          courseId: UUID().uuidString,
          courseName: course.courseName,
          roomName: roomName,
          professor: course.professor,
          courseDay: dayToInt(courseDay: secondDay),
          startTime: startTimeToString(start: secondStartTime),
          endTime: endTimeToString(end: secondEndTime),
          timetableColor: course.timetableColor
        )
      )
    }

    var lastDay = ""
    if let day = components[components.count - 1].first {
      lastDay = String(day)
    }
    let lastTime = components[components.count - 1].dropFirst().split(separator: ",")
    var lastStartTime = ""
    if String(lastTime[0]).contains(")") {
      lastStartTime = String(lastTime[0].dropLast())
    } else {
      lastStartTime = String(lastTime[0])
    }
    let lastEndTime = String(lastTime[lastTime.count - 1].dropLast())
    timeTableCourse.append(
      TimetableCourse(
        courseId: UUID().uuidString,
        courseName: course.courseName,
        roomName: roomName,
        professor: course.professor,
        courseDay: dayToInt(courseDay: lastDay),
        startTime: startTimeToString(start: lastStartTime),
        endTime: endTimeToString(end: lastEndTime),
        timetableColor: course.timetableColor
      )
    )
    return timeTableCourse
  }

  func createDifferentPlaceCourse(course: TimetableCourse) -> [TimetableCourse] {
    var timeTableCourse: [TimetableCourse] = []
    let components = course.roomName.split(separator: "),")

    for i in 0..<components.count {
      let roomName = course.roomName.split(separator: "(")
        .map { String($0) }[0]
      let firstIndex = components[i].firstIndex(of: "(")
      let dayIndex = components[i].index(after: firstIndex!)
      let startIndex = components[i].index(after: dayIndex)
      let dayString = String(components[i][dayIndex])
      let start = String(components[i][startIndex])
      var end = ""
      if i == 0 {
        if let lastString = components[i].last {
          end = String(lastString)
        }
      } else {
        let endTimedropLastString = components[i].dropLast()
        if let lastString = endTimedropLastString.last {
          end = String(lastString)
        }
      }
      let courseDay = dayToInt(courseDay: dayString)
      let startTime = startTimeToString(start: start)
      let endTime = endTimeToString(end: end)
      timeTableCourse.append(
        TimetableCourse(
          courseId: UUID().uuidString,
          courseName: course.courseName,
          roomName: roomName,
          professor: course.professor,
          courseDay: courseDay,
          startTime: startTime,
          endTime: endTime,
          timetableColor: course.timetableColor
        )
      )
    }

    return timeTableCourse
  }

  func isTimeDuplicated(
    existingCourse: TimetableCourse,
    newCourse: TimetableCourse
  ) -> Bool {
    let existingStartTime = existingCourse.startTime.filter { $0 != ":" }
    let existingEndTime = existingCourse.endTime.filter { $0 != ":" }
    let newStartTime = newCourse.startTime.filter { $0 != ":" }
    let newEndTime = newCourse.endTime.filter { $0 != ":" }

    guard let existingStart = Int(existingStartTime),
          let existingEnd = Int(existingEndTime),
          let newStart = Int(newStartTime),
          let newEnd = Int(newEndTime)
    else { return true }

    if existingCourse.courseDay == newCourse.courseDay {
      return !(existingStart > newEnd || existingEnd < newStart)
    } else {
      return false
    }
  }

  func startTimeToString(start: String) -> String {
    let startTimeStringArray = ["9:30", "10:30", "11:30", "12:30", "13:30", "14:30", "15:30", "16:30", "17:30", "18:30", "19:30", "20:30", "21:30", "22:30", "23:30"]
    if let index = Int(start) {
      return startTimeStringArray[index - 1]
    }
    return startTimeStringArray[14]
  }

  func endTimeToString(end: String) -> String {
    let endTimeStringArray = ["10:20", "11:20", "12:20", "13:20", "14:20", "15:20", "16:20", "17:20", "18:20", "19:20", "20:20", "21:20", "22:20", "23:20", "24:20"]
    if let index = Int(end) {
      return endTimeStringArray[index - 1]
    }
    return endTimeStringArray[14]
  }

  private func dayToInt(courseDay: String) -> Int {
    switch courseDay {
    case "월": return 1
    case "화": return 2
    case "수": return 3
    case "목": return 4
    case "금": return 5
    case "토": return 6
    default: return 0
    }
  }
}
