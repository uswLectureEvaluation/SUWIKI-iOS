//
//  FetchExamPostsUseCaseTests.swift
//  DomainTests
//
//  Created by 한지석 on 5/9/24.
//

import XCTest
@testable import DIContainer
@testable import Domain

final class FetchExamPostsUseCaseTests: XCTestCase, ExamPostTestsProtocol {
    func testSuccess() async throws {
        let mockRepository = MockExamPostRepository()
        DIContainer.shared.register(type: ExamPostRepository.self,
                                    mockRepository)
        let useCase = DefaultFetchExamPostUseCase()
        let isFetchCalled = true
        mockRepository.isFetchCalled = isFetchCalled

        let result = try await useCase.execute(id: 1, page: 1)

        XCTAssertEqual(1, result.posts.count)
        XCTAssertTrue(mockRepository.isFetchCalled)
    }
    
    func testFailure() async throws {
        let mockRepository = MockExamPostRepository()
        DIContainer.shared.register(type: ExamPostRepository.self,
                                    mockRepository)
        let useCase = DefaultFetchExamPostUseCase()
        let isFetchCalled = false
        mockRepository.isFetchCalled = isFetchCalled

        let result = try await useCase.execute(id: 1, page: 1)

        XCTAssertEqual(0, result.posts.count)
        XCTAssertFalse(mockRepository.isFetchCalled)
    }
}
