//
//  TimetableRepository.swift
//  SUWIKI
//
//  Created by 한지석 on 4/13/24.
//

import Foundation

protocol TimetableRepository {
    func saveTimetable(name: String, semester: String)
    func saveCourse(id: String, course: TimetableCourse)
    func updateTimetableTitle(id: String, title: String)
    func fetchTimetable(id: String) -> Timetable?
    func fetchCourses(id: String) -> [Course]?
    func fetchELearning(id: String) -> [Course]
    func fetchFirebaseCourse(major: String) -> [FirebaseCourse]
    func fetchMajors() -> [String]
    func fetchTimetableList() -> [Timetable]
    func deleteCourse(id: String, courseId: String)
    func deleteTimetable(id: String)
    func checkCourseVersion() async throws
}
