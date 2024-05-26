//
//  FetchCoursesUseCaseTests.swift
//  DomainTests
//
//  Created by 한지석 on 5/10/24.
//

import XCTest
@testable import DIContainer
@testable import Domain

final class FetchCoursesUseCaseTests: XCTestCase {
    func testSuccess() {
        let mockRepository = MockTimetableRepository()
        DIContainer.shared.register(
            type: TimetableRepository.self,
            mockRepository
        )
        let useCase = DefaultFetchCoursesUseCase()
        let isFetchCoursesCalled = true
        mockRepository.isFetchCoursesCalled = isFetchCoursesCalled
        let id = "10"

        let result = useCase.execute(id: id)

        XCTAssertEqual(id, result?.first?.courseId)
        XCTAssertEqual(1, result?.count)
        XCTAssertTrue(mockRepository.isFetchCoursesCalled)
    }

    func testFailure() {
        let mockRepository = MockTimetableRepository()
        DIContainer.shared.register(
            type: TimetableRepository.self,
            mockRepository
        )
        let useCase = DefaultFetchCoursesUseCase()
        let isFetchCoursesCalled = false
        mockRepository.isFetchCoursesCalled = isFetchCoursesCalled
        let id = "10"

        let result = useCase.execute(id: id)

        XCTAssertNotEqual(id, result?.first?.courseId)
        XCTAssertNotEqual(1, result?.count)
        XCTAssertFalse(mockRepository.isFetchCoursesCalled)
    }
}
