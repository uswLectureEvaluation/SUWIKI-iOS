//
//  FetchEvaluationPostsUseCaseTests.swift
//  DomainTests
//
//  Created by 한지석 on 5/10/24.
//

import XCTest
@testable import DIContainer
@testable import Domain

final class FetchEvaluationPostsUseCaseTests: XCTestCase, TestsProtocol {
    func testSuccess() async throws {
        let mockRepository = MockEvaluationPostRepository()
        DIContainer.shared.register(
            type: EvaluationPostRepository.self,
            mockRepository
        )
        let useCase = DefaultFetchEvaluationPostsUseCase()
        let isFetchCalled = true
        mockRepository.isFetchCalled = isFetchCalled
        let id = 20

        let result = try await useCase.execute(lectureId: id, page: 0)

        XCTAssertEqual(id, mockRepository.id)
        XCTAssertEqual(1, result.posts.count)
        XCTAssertTrue(mockRepository.isFetchCalled)
    }

    func testFailure() async throws {
        let mockRepository = MockEvaluationPostRepository()
        DIContainer.shared.register(
            type: EvaluationPostRepository.self,
            mockRepository
        )
        let useCase = DefaultFetchEvaluationPostsUseCase()
        let isFetchCalled = false
        mockRepository.isFetchCalled = isFetchCalled
        let id = 20

        let result = try await useCase.execute(lectureId: id, page: 0)

        XCTAssertNotEqual(id, mockRepository.id)
        XCTAssertNotEqual(1, result.posts.count)
        XCTAssertFalse(mockRepository.isFetchCalled)
    }
}
