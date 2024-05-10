//
//  FetchUserEvaluationPostsUseCaseTests.swift
//  DomainTests
//
//  Created by 한지석 on 5/10/24.
//

import XCTest
@testable import DIContainer
@testable import Domain

final class FetchUserEvaluationPostsUseCaseTests: XCTestCase, TestsProtocol {
    func testSuccess() async throws {
        let mockRepository = MockEvaluationPostRepository()
        DIContainer.shared.register(
            type: EvaluationPostRepository.self,
            mockRepository
        )
        let useCase = DefaultFetchUserEvaluationPostUseCase()
        let isFetchUserPostsCalled = true
        mockRepository.isFetchUserPostsCalled = isFetchUserPostsCalled

        let result = try await useCase.execute()

        XCTAssertEqual(1, result.count)
        XCTAssertTrue(mockRepository.isFetchUserPostsCalled)
    }

    func testFailure() async throws {
        let mockRepository = MockEvaluationPostRepository()
        DIContainer.shared.register(
            type: EvaluationPostRepository.self,
            mockRepository
        )
        let useCase = DefaultFetchUserEvaluationPostUseCase()
        let isFetchUserPostsCalled = false
        mockRepository.isFetchUserPostsCalled = isFetchUserPostsCalled

        let result = try await useCase.execute()

        XCTAssertNotEqual(1, result.count)
        XCTAssertFalse(mockRepository.isFetchUserPostsCalled)
    }
}
