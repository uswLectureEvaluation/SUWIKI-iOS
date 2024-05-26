//
//  CheckCourseVersionUseCaseTests.swift
//  DomainTests
//
//  Created by 한지석 on 5/10/24.
//

import XCTest
@testable import DIContainer
@testable import Domain

final class CheckCourseVersionUseCaseTests: XCTestCase, TestsProtocol {
    func testSuccess() async throws{
        let mockRepository = MockTimetableRepository()
        DIContainer.shared.register(
            type: TimetableRepository.self,
            mockRepository
        )
        let useCase = DefaultCheckCourseVersionUseCase()
        let isVersionCheckCalled = true
        mockRepository.isVersionCheckCalled = isVersionCheckCalled

        try await useCase.execute()
        
        XCTAssertTrue(mockRepository.isVersionCheckCalled)
    }

    func testFailure() async throws {
        let mockRepository = MockTimetableRepository()
        DIContainer.shared.register(
            type: TimetableRepository.self,
            mockRepository
        )
        let useCase = DefaultCheckCourseVersionUseCase()
        let isVersionCheckCalled = false
        mockRepository.isVersionCheckCalled = isVersionCheckCalled

        try await useCase.execute()

        XCTAssertFalse(mockRepository.isVersionCheckCalled)
    }
}
