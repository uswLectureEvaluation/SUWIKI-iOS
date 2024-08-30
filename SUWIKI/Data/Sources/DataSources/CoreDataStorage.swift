//
//  TimetableStorage.swift
//  SUWIKI
//
//  Created by 한지석 on 4/13/24.
//

import Foundation

import Domain

public protocol CoreDataStorage {
  func saveTimetable(name: String, semester: String) throws
  func saveFirebaseCourse(course: [[String: Any]]) throws
  func saveCourse(id: String, course: TimetableCourse) throws
  func updateTimetableTitle(id: String, title: String) throws
  func fetchTimetable(id: String) throws -> Domain.UserTimetable?
  func fetchCourses(id: String) throws -> [TimetableCourse]?
  func fetchELearning(id: String) throws -> [TimetableCourse]
  func fetchFirebaseCourse(major: String) throws -> [FetchCourse]
  func fetchMajors() throws -> [String]
  func fetchTimetableList() throws -> [Domain.UserTimetable]
  func fetchCourseCount(major: String) throws -> Int
  func deleteCourse(id: String, courseId: String) throws
  func deleteTimetable(id: String) throws
  func deleteFirebaseCourse() throws
}
