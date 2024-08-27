//
//  TimeTableViewModel.swift
//  SUWIKI
//
//  Created by 한지석 on 2023/06/13.
//

import Foundation

import DIContainer
import Domain

import Elliotable

final class TimetableViewModel {
  
  @Inject var fetchTimetableUseCase: FetchTimetableUseCase
  @Inject var fetchCoursesUseCase: FetchCoursesUseCase
  @Inject var saveTimeTableUseCase: SaveTimetableUseCase
  @Inject var updateTimetableTitleUseCase: UpdateTimetableTitleUseCase
  @Inject var deleteCourseUseCase: DeleteCourseUseCase
  @Inject var fetchTimetableListUseCase: FetchTimetableListUseCase
  @Inject var checkCourseVersionUseCase: CheckCourseVersionUseCase
  
  @Published var elliottEvent: [ElliottEvent] = []
  @Published var timetableTitle: String = ""
  @Published var timetableIsEmpty: Bool = false
  @Published var isVersionChecked: Bool = false
  
  init() {
    fetchTimetable()
    Task {
      try await fetchFirebaseCourse()
    }
  }
  
  func fetchTimetable() {
    let timetable = fetchTimetableListUseCase.execute()
    updateCourse()
    self.timetableIsEmpty = timetable.isEmpty
  }
  
  func addTimetable() {
    let calculateSemester = calculateSemester()
    saveTimeTableUseCase.execute(name: calculateSemester.0,
                                 semester: calculateSemester.1)
    updateTimetable()
    updateCourse()
  }
  
  func updateTimetable() {
    guard let id = UserDefaults.shared.value(forKey: "id") as? String,
          let title = fetchTimetableUseCase.execute(id: id)?.name else {
      self.timetableTitle = "시간표"
      self.timetableIsEmpty = true
      return
    }
    self.timetableTitle = title
  }
  
  func updateCourse() {
    guard let id = UserDefaults.shared.value(forKey: "id") as? String,
          let course = fetchCoursesUseCase.execute(id: id)
    else {
      self.timetableIsEmpty = true
      return
    }
    elliottEvent = course.map { ElliottEvent(courseId: $0.courseId ?? "",
                                             courseName: $0.courseName ?? "",
                                             roomName: $0.roomName ?? "",
                                             professor: $0.professor ?? "",
                                             courseDay: ElliotDay(rawValue: Int($0.courseDay)) ?? .monday,
                                             startTime: $0.startTime ?? "",
                                             endTime: $0.endTime ?? "",
                                             backgroundColor: .timetableColors[Int($0.timetableColor)]) }
    self.timetableIsEmpty = false
  }
  
  func updateTimetableTitle(title: String) {
    guard let id = UserDefaults.shared.value(forKey: "id") as? String else { return }
    updateTimetableTitleUseCase.execute(id: id, title: title)
    self.timetableTitle = title
  }
  
  func deleteCourse(courseId: String) {
    guard let index = elliottEvent.firstIndex(where: { $0.courseId == courseId }),
          let id = UserDefaults.shared.value(forKey: "id") as? String
    else { return }
    elliottEvent.remove(at: index)
    deleteCourseUseCase.execute(id: id, courseId: courseId)
  }
  
  func calculateSemester() -> (String, String) {
    let currentYear = Calendar.current.component(.year, from: Date())
    let currentMonth = Calendar.current.component(.month, from: Date())
    if currentMonth <= 6 {
      return ("\(currentYear) - 1", "\(currentYear)년 1학기")
    } else {
      return ("\(currentYear) - 2", "\(currentYear)년 2학기")
    }
  }
  
  func fetchFirebaseCourse() async throws {
    try await checkCourseVersionUseCase.execute()
    await MainActor.run {
      self.isVersionChecked.toggle()
    }
  }
  
}
