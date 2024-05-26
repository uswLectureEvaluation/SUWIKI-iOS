//
//  FetchTimetableUseCaseTests.swift
//  DomainTests
//
//  Created by 한지석 on 5/10/24.
//

import XCTest
@testable import DIContainer
@testable import Domain

final class FetchTimetableUseCaseTests: XCTestCase {
    func testSuccess() {
        let mockRepository = MockTimetableRepository()
        DIContainer.shared.register(
            type: TimetableRepository.self,
            mockRepository
        )
        let useCase = DefaultFetchTimetableUseCase()
        let isFetchTimetableCalled = true
        mockRepository.isFetchTimetableCalled = isFetchTimetableCalled
        let id = "10"

        let result = useCase.execute(id: id)

        XCTAssertEqual(id, result?.id)
        XCTAssertEqual(isFetchTimetableCalled, mockRepository.isFetchTimetableCalled)
    }

    func testFailure() {
        let mockRepository = MockTimetableRepository()
        DIContainer.shared.register(
            type: TimetableRepository.self,
            mockRepository
        )
        let useCase = DefaultFetchTimetableUseCase()
        let isFetchTimetableCalled = false
        mockRepository.isFetchTimetableCalled = isFetchTimetableCalled
        let id = "10"

        let result = useCase.execute(id: id)

        XCTAssertNotEqual(id, result?.id)
        XCTAssertEqual(isFetchTimetableCalled, mockRepository.isFetchTimetableCalled)
    }
}
