//
//  UpdateTimetableTitleUseCaseTests.swift
//  DomainTests
//
//  Created by 한지석 on 5/10/24.
//

import XCTest
@testable import DIContainer
@testable import Domain

final class UpdateTimetableTitleUseCaseTests: XCTestCase {
    func testSuccess() {
        let mockRepository = MockTimetableRepository()
        DIContainer.shared.register(
            type: TimetableRepository.self,
            mockRepository
        )
        let useCase = DefaultUpdateTimetableTitleUseCase()
        let isUpdateTimetableCalled = true
        mockRepository.isUpdateTimetableCalled = isUpdateTimetableCalled

        useCase.execute(id: "", title: "")

        XCTAssertEqual(isUpdateTimetableCalled, mockRepository.isUpdateTimetableCalled)
    }

    func testFailure() {
        let mockRepository = MockTimetableRepository()
        DIContainer.shared.register(
            type: TimetableRepository.self,
            mockRepository
        )
        let useCase = DefaultUpdateTimetableTitleUseCase()
        let isUpdateTimetableCalled = false
        mockRepository.isUpdateTimetableCalled = isUpdateTimetableCalled

        useCase.execute(id: "", title: "")

        XCTAssertEqual(isUpdateTimetableCalled, mockRepository.isUpdateTimetableCalled)
    }

}
