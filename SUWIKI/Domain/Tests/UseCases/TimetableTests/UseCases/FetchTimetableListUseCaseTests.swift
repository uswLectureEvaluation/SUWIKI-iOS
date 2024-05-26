//
//  FetchTimetableListUseCaseTests.swift
//  DomainTests
//
//  Created by 한지석 on 5/10/24.
//

import XCTest
@testable import DIContainer
@testable import Domain

final class FetchTimetableListUseCaseTests: XCTestCase {
    func testSuccess() {
        let mockRepository = MockTimetableRepository()
        DIContainer.shared.register(
            type: TimetableRepository.self,
            mockRepository
        )
        let useCase = DefaultFetchTimetableListUseCase()
        let isFetchTimetableListCalled = true
        mockRepository.isFetchTimetableListCalled = isFetchTimetableListCalled

        let result = useCase.execute()

        XCTAssertEqual(1, result.count)
        XCTAssertTrue(mockRepository.isFetchTimetableListCalled)
    }
    func testFailure() {
        let mockRepository = MockTimetableRepository()
        DIContainer.shared.register(
            type: TimetableRepository.self,
            mockRepository
        )
        let useCase = DefaultFetchTimetableListUseCase()
        let isFetchTimetableListCalled = false
        mockRepository.isFetchTimetableListCalled = isFetchTimetableListCalled

        let result = useCase.execute()

        XCTAssertNotEqual(1, result.count)
        XCTAssertFalse(mockRepository.isFetchTimetableListCalled)
    }
}
