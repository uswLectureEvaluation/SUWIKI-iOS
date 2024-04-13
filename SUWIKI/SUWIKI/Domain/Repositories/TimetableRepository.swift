//
//  TimetableRepository.swift
//  SUWIKI
//
//  Created by 한지석 on 4/13/24.
//

import Foundation

protocol TimetableRepository {
    func saveTimetable(name: String, semester: String)
    func fetchTimetable(id: String) -> Timetable?
    func fetchCourses(id: String) -> [Course]?
}
