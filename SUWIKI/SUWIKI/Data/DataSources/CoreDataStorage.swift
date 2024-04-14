//
//  TimetableStorage.swift
//  SUWIKI
//
//  Created by 한지석 on 4/13/24.
//

import Foundation

protocol CoreDataStorage {
    func saveTimetable(name: String, semester: String) throws
    func saveFirebaseCourse(course: [[String: Any]]) throws
    func saveCourse(id: String, course: TimetableCourse) throws
    func updateTimetableTitle(id: String, title: String) throws
    func fetchTimetable(id: String) throws -> Timetable?
    func fetchCourses(id: String) throws -> [Course]?
    func fetchELearning(id: String) throws -> [Course]
    func fetchFirebaseCourse(major: String) throws -> [FirebaseCourse]
    func fetchMajors() throws -> [String]
    func fetchTimetableList() throws -> [Timetable]
    func deleteCourse(id: String, courseId: String) throws
    func deleteTimetable(id: String) throws
    func deleteFirebaseCourse() throws
}
