//
//  UpdateEvaluationPostUseCaseTests.swift
//  DomainTests
//
//  Created by 한지석 on 5/10/24.
//

import XCTest
@testable import DIContainer
@testable import Domain

final class UpdateEvaluationPostUseCaseTests: XCTestCase, TestsProtocol {
    func testSuccess() async throws {
        let mockRepository = MockEvaluationPostRepository()
        DIContainer.shared.register(
            type: EvaluationPostRepository.self,
            mockRepository
        )
        let useCase = DefaultUpdateEvaluationPostUseCase()
        let id = 10
        let isUpdateCalled = true
        mockRepository.isUpdateCalled = isUpdateCalled

        let result = try await useCase.execute(
            id: id,
            lectureName: "",
            professor: "",
            selectedSemester: "",
            satisfaction: 1,
            learning: 1,
            honey: 1,
            team: 1,
            difficulty: 1,
            homework: 1,
            content: ""
        )

        XCTAssertEqual(id, mockRepository.id)
        XCTAssertEqual(isUpdateCalled, mockRepository.isUpdateCalled)
    }

    func testFailure() async throws {
        let mockRepository = MockEvaluationPostRepository()
        DIContainer.shared.register(
            type: EvaluationPostRepository.self,
            mockRepository
        )
        let useCase = DefaultUpdateEvaluationPostUseCase()
        let id = 10
        let isUpdateCalled = false
        mockRepository.isUpdateCalled = isUpdateCalled

        let result = try await useCase.execute(
            id: id,
            lectureName: "",
            professor: "",
            selectedSemester: "",
            satisfaction: 1,
            learning: 1,
            honey: 1,
            team: 1,
            difficulty: 1,
            homework: 1,
            content: ""
        )

        XCTAssertNotEqual(id, mockRepository.id)
        XCTAssertFalse(mockRepository.isUpdateCalled)
    }
}
