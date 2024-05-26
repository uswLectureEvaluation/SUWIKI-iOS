//
//  SaveCourseUseCaseTests.swift
//  DomainTests
//
//  Created by 한지석 on 5/10/24.
//

import XCTest
@testable import DIContainer
@testable import Domain

final class SaveCourseUseCaseTests: XCTestCase {
    func testSuccess() {
        let mockRepository = MockTimetableRepository()
        DIContainer.shared.register(
            type: TimetableRepository.self,
            mockRepository
        )
        let useCase = DefaultSaveCourseUseCase()
        let isSaveCourseCalled = true
        mockRepository.isSaveCourseCalled = isSaveCourseCalled

        useCase.execute(id: "", course: TimetableCourse(courseId: "",
                                                        courseName: "",
                                                        roomName: "",
                                                        professor: "",
                                                        courseDay: 1,
                                                        startTime: "",
                                                        endTime: "",
                                                        timetableColor: 1))

        XCTAssertEqual(isSaveCourseCalled, mockRepository.isSaveCourseCalled)
    }

    func testFailure() {
        let mockRepository = MockTimetableRepository()
        DIContainer.shared.register(
            type: TimetableRepository.self,
            mockRepository
        )
        let useCase = DefaultSaveCourseUseCase()
        let isSaveCourseCalled = false
        mockRepository.isSaveCourseCalled = isSaveCourseCalled

        useCase.execute(id: "", course: TimetableCourse(courseId: "",
                                                        courseName: "",
                                                        roomName: "",
                                                        professor: "",
                                                        courseDay: 1,
                                                        startTime: "",
                                                        endTime: "",
                                                        timetableColor: 1))

        XCTAssertEqual(isSaveCourseCalled, mockRepository.isSaveCourseCalled)
    }
}
