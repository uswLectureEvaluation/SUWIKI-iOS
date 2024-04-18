//
//  DefaultTimetableRepository.swift
//  SUWIKI
//
//  Created by 한지석 on 4/13/24.
//

import Foundation

import DIContainer

final class DefaultTimetableRepository: TimetableRepository {

    @Inject var coreDataStorage: CoreDataStorage
    @Inject var firebaseStorage: FirebaseStorage

    func saveTimetable(
        name: String,
        semester: String
    ) {
        do {
            try coreDataStorage.saveTimetable(name: name, semester: semester)
        } catch {
            print("@Log - \(error.localizedDescription)")
        }
    }

    func saveCourse(id: String, course: TimetableCourse) {
        do {
            try coreDataStorage.saveCourse(id: id, course: course)
        } catch {
            print("@Log - \(error.localizedDescription)")
        }
    }

    func updateTimetableTitle(id: String, title: String) {
        do {
            try coreDataStorage.updateTimetableTitle(id: id, title: title)
        } catch {
            print("@Log - \(error.localizedDescription)")
        }
    }

    func fetchTimetable(id: String) -> Timetable? {
        do {
            return try coreDataStorage.fetchTimetable(id: id)
        } catch {
            return nil
        }
    }

    func fetchCourses(id: String) -> [Course]? {
        do {
            return try coreDataStorage.fetchCourses(id: id)
        } catch {
            return nil
        }
    }

    func fetchFirebaseCourse(major: String) -> [FirebaseCourse] {
        do {
            return try coreDataStorage.fetchFirebaseCourse(major: major)
        } catch {
            return []
        }
    }

    func fetchMajors() -> [String] {
        do {
            return try coreDataStorage.fetchMajors()
        } catch {
            return []
        }
    }

    func fetchTimetableList() -> [Timetable] {
        do {
            return try coreDataStorage.fetchTimetableList()
        } catch {
            print("@Log - \(error.localizedDescription)")
            return []
        }
    }

    func fetchELearning(id: String) -> [Course] {
        do {
            return try coreDataStorage.fetchELearning(id: id)
        } catch {
            return []
        }
    }

    func deleteCourse(
        id: String,
        courseId: String
    ) {
        do {
            try coreDataStorage.deleteCourse(id: id, courseId: courseId)
        } catch {
            print("@Log - \(error.localizedDescription)")
        }
    }

    func deleteTimetable(id: String) {
        do {
            try coreDataStorage.deleteTimetable(id: id)
        } catch {
            print("@Log - \(error.localizedDescription)")
        }
    }

    func checkCourseVersion() async throws {
        do {
            try await firebaseStorage.isVersionChanged()
        } catch {
            print("@Log - \(error.localizedDescription)")
        }
    }

}
