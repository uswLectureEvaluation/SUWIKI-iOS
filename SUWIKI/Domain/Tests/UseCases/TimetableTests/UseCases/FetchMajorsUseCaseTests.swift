//
//  FetchMajorsUseCaseTests.swift
//  DomainTests
//
//  Created by 한지석 on 5/10/24.
//

import XCTest
@testable import DIContainer
@testable import Domain

final class FetchMajorsUseCaseTests: XCTestCase {
    func testSuccess() {
        let mockRepository = MockTimetableRepository()
        DIContainer.shared.register(
            type: TimetableRepository.self,
            mockRepository
        )
        let useCase = DefaultFetchMajorsUseCase()
        let isFetchMajorsCalled = true
        mockRepository.isFetchMajorsCalled = isFetchMajorsCalled

        let result = useCase.execute()

        XCTAssertEqual(2, result.count)
        XCTAssertEqual("전체", result.first)
        XCTAssertTrue(mockRepository.isFetchMajorsCalled)
    }

    func testFailure() {
        let mockRepository = MockTimetableRepository()
        DIContainer.shared.register(
            type: TimetableRepository.self,
            mockRepository
        )
        let useCase = DefaultFetchMajorsUseCase()
        let isFetchMajorsCalled = false
        mockRepository.isFetchMajorsCalled = isFetchMajorsCalled

        let result = useCase.execute()

        XCTAssertNotEqual(2, result.count)
        XCTAssertNotEqual("전체", result.first)
        XCTAssertFalse(mockRepository.isFetchMajorsCalled)
    }

}
