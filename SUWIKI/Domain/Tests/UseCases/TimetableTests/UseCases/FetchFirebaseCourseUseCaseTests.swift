//
//  FetchFirebaseCourseUseCaseTests.swift
//  DomainTests
//
//  Created by 한지석 on 5/10/24.
//

import XCTest
@testable import DIContainer
@testable import Domain

final class FetchFirebaseCourseUseCaseTests: XCTestCase {
    func testSuccess() {
        let mockRepository = MockTimetableRepository()
        DIContainer.shared.register(
            type: TimetableRepository.self,
            mockRepository
        )
        let useCase = DefaultFetchFirebaseCourseUseCase()
        let isFetchFirebaseCourseCalled = true
        mockRepository.isFetchFirebaseCourseCalled = isFetchFirebaseCourseCalled
        let major = "전체"

        let result = useCase.execute(major: major)

        XCTAssertEqual(major, result.first?.major)
        XCTAssertEqual(1, result.count)
        XCTAssertTrue(mockRepository.isFetchFirebaseCourseCalled)
    }

    func testFailure() {
        let mockRepository = MockTimetableRepository()
        DIContainer.shared.register(
            type: TimetableRepository.self,
            mockRepository
        )
        let useCase = DefaultFetchFirebaseCourseUseCase()
        let isFetchFirebaseCourseCalled = false
        mockRepository.isFetchFirebaseCourseCalled = isFetchFirebaseCourseCalled
        let major = "전체"

        let result = useCase.execute(major: major)

        XCTAssertNotEqual(major, result.first?.major)
        XCTAssertNotEqual(1, result.count)
        XCTAssertFalse(mockRepository.isFetchFirebaseCourseCalled)
    }
}
