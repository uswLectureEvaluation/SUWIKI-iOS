//
//  SaveTimetableUseCaseTests.swift
//  DomainTests
//
//  Created by 한지석 on 5/10/24.
//

import XCTest
@testable import DIContainer
@testable import Domain

final class SaveTimetableUseCaseTests: XCTestCase {
    func testSuccess() {
        let mockRepository = MockTimetableRepository()
        DIContainer.shared.register(
            type: TimetableRepository.self,
            mockRepository
        )
        let useCase = DefaultSaveTimetableUseCase()
        let isSaveTimetableCalled = true
        mockRepository.isSaveTimetableCalled = isSaveTimetableCalled

        let _ = useCase.execute(name: "", semester: "")

        XCTAssertEqual(isSaveTimetableCalled, mockRepository.isSaveTimetableCalled)
    }

    func testFailure() {
        let mockRepository = MockTimetableRepository()
        DIContainer.shared.register(
            type: TimetableRepository.self,
            mockRepository
        )
        let useCase = DefaultSaveTimetableUseCase()
        let isSaveTimetableCalled = false
        mockRepository.isSaveTimetableCalled = isSaveTimetableCalled

        let _ = useCase.execute(name: "", semester: "")

        XCTAssertEqual(isSaveTimetableCalled, mockRepository.isSaveTimetableCalled)
    }
}
