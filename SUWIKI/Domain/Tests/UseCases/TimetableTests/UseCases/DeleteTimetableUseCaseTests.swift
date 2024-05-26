//
//  DeleteTimetableUseCaseTests.swift
//  DomainTests
//
//  Created by 한지석 on 5/10/24.
//

import XCTest
@testable import DIContainer
@testable import Domain

final class DeleteTimetableUseCaseTests: XCTestCase {
    func testSuccess() {
        let mockRepository = MockTimetableRepository()
        DIContainer.shared.register(
            type: TimetableRepository.self,
            mockRepository
        )
        let useCase = DefaultDeleteTimeTableUseCase()
        let isDeleteTimetableCalled = true
        mockRepository.isDeleteTimetableCalled = isDeleteTimetableCalled

        useCase.execute(id: "")

        XCTAssertEqual(isDeleteTimetableCalled, mockRepository.isDeleteTimetableCalled)
    }

    func testFailure() {
        let mockRepository = MockTimetableRepository()
        DIContainer.shared.register(
            type: TimetableRepository.self,
            mockRepository
        )
        let useCase = DefaultDeleteTimeTableUseCase()
        let isDeleteTimetableCalled = false
        mockRepository.isDeleteTimetableCalled = isDeleteTimetableCalled

        useCase.execute(id: "")

        XCTAssertEqual(isDeleteTimetableCalled, mockRepository.isDeleteTimetableCalled)
    }
}
