//
//  TimetableRepository.swift
//  SUWIKI
//
//  Created by 한지석 on 4/13/24.
//

import Foundation

public protocol TimetableRepository {
  func saveTimetable(name: String, semester: String) -> Result<(), CoreDataError>
  func saveCourse(id: String, course: TimetableCourse) -> Result<(), CoreDataError>
  func updateTimetableTitle(id: String, title: String) -> Result<(), CoreDataError>
  func fetchTimetable(id: String) -> Result<UserTimetable?, CoreDataError>
  func fetchCourses(id: String) -> Result<[TimetableCourse]?, CoreDataError>
  func fetchELearning(id: String) -> Result<[TimetableCourse], CoreDataError>
  func fetchFirebaseCourse(major: String) -> Result<[FetchCourse], CoreDataError>
  func fetchMajors() -> Result<[String], CoreDataError>
  func fetchTimetableList() -> Result<[UserTimetable], CoreDataError>
  func deleteCourse(id: String, courseId: String) -> Result<(), CoreDataError>
  func deleteTimetable(id: String) -> Result<(), CoreDataError>
  func checkCourseVersion() async throws -> Result<(), CoreDataError>
}
