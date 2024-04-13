//
//  DefaultTimetableRepository.swift
//  SUWIKI
//
//  Created by 한지석 on 4/13/24.
//

import Foundation

final class DefaultTimetableRepository: TimetableRepository {

    @Inject var storage: TimetableStorage

    func saveTimetable(
        name: String,
        semester: String
    ) {
        do {
            try storage.saveTimetable(name: name, semester: semester)
        } catch {
            print("@Log - \(error.localizedDescription)")
        }
    }

    func fetchTimetable(id: String) -> Timetable? {
        do {
            return try storage.fetchTimetable(id: id)
        } catch {
            return nil
        }
    }

    func fetchCourses(id: String) -> [Course]? {
        do {
            return try storage.fetchCourses(id: id)
        } catch {
            return nil
        }
    }
}
