//
//  MockTimetableRepository.swift
//  DomainTests
//
//  Created by 한지석 on 5/10/24.
//

import Foundation

import Domain

final class MockTimetableRepository: TimetableRepository {

    var isSaveTimetableCalled = false
    var isSaveCourseCalled = false
    var isUpdateTimetableCalled = false
    var isFetchTimetableCalled = false
    var isFetchCoursesCalled = false
    var isFetchELearningCalled = false
    var isFetchFirebaseCourseCalled = false
    var isFetchMajorsCalled = false
    var isFetchTimetableListCalled = false
    var isDeleteCourseCalled = false
    var isDeleteTimetableCalled = false
    var isVersionCheckCalled = false

    func saveTimetable(
        name: String,
        semester: String
    ) -> Result<(), CoreDataError> {
        if isSaveTimetableCalled {
            return .success(())
        } else {
            return .failure(.saveError)
        }
    }

    func saveCourse(
        id: String,
        course: TimetableCourse
    ) -> Result<(), Domain.CoreDataError> {
        if isSaveCourseCalled {
            return .success(())
        } else {
            return .failure(.saveError)
        }
    }

    func updateTimetableTitle(
        id: String,
        title: String
    ) -> Result<(), CoreDataError> {
        if isUpdateTimetableCalled {
            return .success(())
        } else {
            return .failure(.saveError)
        }
    }

    func fetchTimetable(id: String) -> Result<UserTimetable?, CoreDataError> {
        if isFetchTimetableCalled {
            return .success(UserTimetable(id: id, name: "", semester: "", courses: []))
        } else {
            return .failure(.fetchError)
        }
    }

    func fetchCourses(id: String) -> Result<[TimetableCourse]?, CoreDataError> {
        if isFetchCoursesCalled {
            return .success([TimetableCourse(
                courseId: id,
                courseName: "",
                roomName: "",
                professor: "",
                courseDay: 0,
                startTime: "",
                endTime: "",
                timetableColor: 0
            )])
        } else {
            return .failure(.fetchError)
        }
    }

    func fetchELearning(id: String) -> Result<[TimetableCourse], CoreDataError> {
        if isFetchELearningCalled {
            return .success([TimetableCourse(
                courseId: id,
                courseName: "",
                roomName: "",
                professor: "",
                courseDay: 1,
                startTime: "",
                endTime: "",
                timetableColor: 1
            )])
        } else {
            return .failure(.fetchError)
        }
    }

    func fetchFirebaseCourse(major: String) -> Result<[FetchCourse], CoreDataError> {
        if isFetchFirebaseCourseCalled {
            return .success([FetchCourse(
                classNum: "",
                classification: "",
                courseDay: "",
                courseName: "",
                credit: 1,
                startTime: "",
                endTime: "",
                major: major,
                num: 1,
                professor: "",
                roomName: ""
            )])
        } else {
            return .failure(.fetchError)
        }
    }

    func fetchMajors() -> Result<[String], CoreDataError> {
        if isFetchMajorsCalled {
            return .success(["전체", "정보보호"])
        } else {
            return .failure(.fetchError)
        }
    }

    func fetchTimetableList() -> Result<[UserTimetable], CoreDataError> {
        if isFetchTimetableListCalled {
            return .success([UserTimetable(id: "", name: "", semester: "", courses: [])])
        } else {
            return .failure(.fetchError)
        }
    }

    func deleteCourse(
        id: String,
        courseId: String
    ) -> Result<(), CoreDataError> {
        if isDeleteCourseCalled {
            return .success(())
        } else {
            return .failure(.deleteError)
        }
    }

    func deleteTimetable(id: String) -> Result<(), CoreDataError> {
        if isDeleteTimetableCalled {
            return .success(())
        } else {
            return .failure(.deleteError)
        }
    }

    func checkCourseVersion() async throws -> Result<(), CoreDataError> {
        if isVersionCheckCalled {
            return .success(())
        } else {
            return .failure(.contextError)
        }
    }
}
