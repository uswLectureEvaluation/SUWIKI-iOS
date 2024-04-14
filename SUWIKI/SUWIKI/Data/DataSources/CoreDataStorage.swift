//
//  TimetableStorage.swift
//  SUWIKI
//
//  Created by 한지석 on 4/13/24.
//

import Foundation

protocol CoreDataStorage {
    func saveTimetable(name: String, semester: String) throws
    func updateTimetableTitle(id: String, title: String) throws
    func fetchTimetable(id: String) throws -> Timetable?
    func fetchCourses(id: String) throws -> [Course]?
    func fetchTimetableList() throws -> [Timetable]
    func deleteCourse(id: String, courseId: String) throws
}
