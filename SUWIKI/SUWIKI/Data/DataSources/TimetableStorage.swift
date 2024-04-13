//
//  TimetableStorage.swift
//  SUWIKI
//
//  Created by 한지석 on 4/13/24.
//

import Foundation

protocol TimetableStorage {
    func saveTimetable(name: String, semester: String) throws
    func fetchTimetable(id: String) throws -> Timetable?
    func fetchCourses(id: String) throws -> [Course]?
}
