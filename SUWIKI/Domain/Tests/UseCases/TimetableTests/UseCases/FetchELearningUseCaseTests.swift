//
//  FetchELearningUseCaseTests.swift
//  DomainTests
//
//  Created by 한지석 on 5/10/24.
//

import XCTest
@testable import DIContainer
@testable import Domain

final class FetchELearningUseCaseTests: XCTestCase {
    func testSuccess() {
        let mockRepository = MockTimetableRepository()
        DIContainer.shared.register(
            type: TimetableRepository.self,
            mockRepository
        )
        let useCase = DefaultFetchELearningUseCase()
        let isFetchELearningCalled = true
        mockRepository.isFetchELearningCalled = isFetchELearningCalled
        let id = "10"

        let result = useCase.execute(id: id)

        XCTAssertEqual(1, result.count)
        XCTAssertEqual(id, result.first?.courseId)
        XCTAssertTrue(mockRepository.isFetchELearningCalled)
    }

    func testFailure() {
        let mockRepository = MockTimetableRepository()
        DIContainer.shared.register(
            type: TimetableRepository.self,
            mockRepository
        )
        let useCase = DefaultFetchELearningUseCase()
        let isFetchELearningCalled = false
        mockRepository.isFetchELearningCalled = isFetchELearningCalled
        let id = "10"

        let result = useCase.execute(id: id)

        XCTAssertNotEqual(1, result.count)
        XCTAssertNotEqual(id, result.first?.courseId)
        XCTAssertFalse(mockRepository.isFetchELearningCalled)
    }
}
