//
//  FetchUserExamPostsUseCaseTests.swift
//  DomainTests
//
//  Created by 한지석 on 5/9/24.
//

import XCTest
@testable import DIContainer
@testable import Domain

final class FetchUserExamPostsUseCaseTests: XCTestCase, ExamPostTestsProtocol {
    func testSuccess() async throws {
        /// given
        let mockRepository = MockExamPostRepository()
        DIContainer.shared.register(type: ExamPostRepository.self,
                                    mockRepository)
        let useCase = DefaultFetchUserExamPostsUseCase()
        let isFetchUserPostCalled = true
        mockRepository.isFetchUserPostCalled = isFetchUserPostCalled

        /// when
        let result = try await useCase.execute()

        /// then
        XCTAssertEqual(1, result.count)
        XCTAssertTrue(mockRepository.isFetchUserPostCalled == isFetchUserPostCalled)
    }
    
    func testFailure() async throws {
        /// given
        let mockRepository = MockExamPostRepository()
        DIContainer.shared.register(type: ExamPostRepository.self,
                                    mockRepository)
        let useCase = DefaultFetchUserExamPostsUseCase()
        let isFetchUserPostCalled = false
        mockRepository.isFetchUserPostCalled = isFetchUserPostCalled

        /// when
        let result = try await useCase.execute()

        /// then
        XCTAssertEqual(0, result.count)
        XCTAssertFalse(mockRepository.isFetchUserPostCalled)
    }
}
