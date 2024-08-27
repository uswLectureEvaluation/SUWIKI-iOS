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
    
    var isDuplicated = false
    
    var course: [TimetableCourse] = []
    switch duplicateCase {
    case .eLearning:
      let eLearning = eLearning(id: id, course: newCourse)
      course.append(eLearning)
    case .normal:
      let roomName = newCourse.roomName.split(separator: "(").map { String($0) }[0]
      let normalCourse = TimetableCourse(courseId: newCourse.courseId,
                                         courseName: newCourse.courseName,
                                         roomName: roomName,
                                         professor: newCourse.professor,
                                         courseDay: newCourse.courseDay,
                                         startTime: newCourse.startTime,
                                         endTime: newCourse.endTime,
                                         timetableColor: newCourse.timetableColor)
      course.append(normalCourse)
    case .differentTime:
      course = differentTime(course: newCourse)
    case .differentPlace:
      course = differentPlace(course: newCourse)
    }
    isDuplicated = isCourseDuplicated(existingCourse: timetableCourse, course: course)
    if !isDuplicated {
      for i in 0..<course.count {
        saveCourseUseCase.execute(id: id, course: course[i])
      }
    }
    return isDuplicated
  }
  
  func isCourseDuplicated(
    existingCourse: [TimetableCourse],
    course: [TimetableCourse]
  ) -> Bool {
    var isDuplicated = false
    for i in 0..<existingCourse.count {
      for j in 0..<course.count {
        if isTimeDuplicated(existingCourse: existingCourse[i], newCourse: course[j]) {
          isDuplicated = true
          break
        }
      }
    }
    return isDuplicated
  }
  
  func eLearning(
    id: String,
    course: TimetableCourse
  ) -> TimetableCourse {
    let eStart = ["9:30", "11:30", "13:30"]
    let eEnd = ["11:20", "13:20", "15:20"]
    let eLearningCourses = fetchELearningUseCase.execute(id: id)
    let nums = eLearningCourses.count < 3 ? eLearningCourses.count : 0
    let eLearning = TimetableCourse(courseId: course.courseId,
                                    courseName: course.courseName,
                                    roomName: course.roomName,
                                    professor: course.professor,
                                    courseDay: 6,
                                    startTime: eStart[nums],
                                    endTime: eEnd[nums],
                                    timetableColor: course.timetableColor)
    return eLearning
  }
  
  func differentTime(course: TimetableCourse) -> [TimetableCourse] {
    var timeTableCourse: [TimetableCourse] = []
    let components = course.roomName.split(separator: " ")
    let roomName = course.roomName.split(separator: "(").map { String($0)} [0]
    let firstIndex = components[0].firstIndex(of: "(")
    let firstDayIndex = components[0].index(after: firstIndex!)
    let firstDay = String(components[0][firstDayIndex])
    let firstTime = components[0].split(separator: firstDay)[1].split(separator: ",")
    let firstStartTime = String(firstTime[0])
    let firstEndTime = String(firstTime[firstTime.count - 1])
    timeTableCourse.append(TimetableCourse(courseId: UUID().uuidString,
                                           courseName: course.courseName,
                                           roomName: roomName,
                                           professor: course.professor,
                                           courseDay: dayToInt(courseDay: firstDay),
                                           startTime: startTimeToString(start: firstStartTime),
                                           endTime: endTimeToString(end: firstEndTime),
                                           timetableColor: course.timetableColor))
    if components.count == 3 {
      var secondDay = ""
      if let day = components[1].first {
        secondDay = String(day)
      }
      let secondTime = components[1].dropFirst().split(separator: ",")
      let secondStartTime = String(secondTime[0])
      let secondEndTime = String(secondTime[secondTime.count - 1])
      timeTableCourse.append(TimetableCourse(courseId: UUID().uuidString,
                                             courseName: course.courseName,
                                             roomName: roomName,
                                             professor: course.professor,
                                             courseDay: dayToInt(courseDay: secondDay),
                                             startTime: startTimeToString(start: secondStartTime),
                                             endTime: endTimeToString(end: secondEndTime),
                                             timetableColor: course.timetableColor))
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
    timeTableCourse.append(TimetableCourse(courseId: UUID().uuidString,
                                           courseName: course.courseName,
                                           roomName: roomName,
                                           professor: course.professor,
                                           courseDay: dayToInt(courseDay: lastDay),
                                           startTime: startTimeToString(start: lastStartTime),
                                           endTime: endTimeToString(end: lastEndTime),
                                           timetableColor: course.timetableColor))
    return timeTableCourse
  }
  
  func differentPlace(course: TimetableCourse) -> [TimetableCourse] {
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
      timeTableCourse.append(TimetableCourse(courseId: UUID().uuidString,
                                             courseName: course.courseName,
                                             roomName: roomName,
                                             professor: course.professor,
                                             courseDay: courseDay,
                                             startTime: startTime,
                                             endTime: endTime,
                                             timetableColor: course.timetableColor))
    }
    
    return timeTableCourse
  }
  
  func isTimeDuplicated(
    existingCourse: TimetableCourse,
    newCourse: TimetableCourse
  ) -> Bool {
    let existingCourseStartTimeStr = existingCourse.startTime.filter { $0 != ":" }
    let existingCourseEndTimeStr = existingCourse.endTime.filter { $0 != ":" }
    let newCourseStartTimeStr = newCourse.startTime.filter { $0 != ":" }
    let newCourseEndTimeStr = newCourse.endTime.filter { $0 != ":" }
    guard let existingCourseStartTime = Int(existingCourseStartTimeStr),
          let existingCourseEndTime = Int(existingCourseEndTimeStr),
          let newCourseStartTime = Int(newCourseStartTimeStr),
          let newCourseEndTime = Int(newCourseEndTimeStr)
    else { return true }
    if existingCourse.courseDay == newCourse.courseDay {
      return !(existingCourseStartTime > newCourseEndTime || existingCourseEndTime < newCourseStartTime)
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
    case "토":
      dayToString = 6
    default:
      break
    }
    return dayToString
  }
}
