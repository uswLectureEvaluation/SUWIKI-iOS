//
//  FetchPurchasedExamPostsUseCaseTests.swift
//  DomainTests
//
//  Created by 한지석 on 5/9/24.
//

import XCTest
@testable import DIContainer
@testable import Domain

final class FetchPurchasedExamPostsUseCaseTests: XCTestCase, ExamPostTestsProtocol {
    func testSuccess() async throws {
        /// given
        let mockRepository = MockExamPostRepository()
        DIContainer.shared.register(type: ExamPostRepository.self,
                                    mockRepository)
        let useCase = DefaultFetchPurchasedExamPostsUseCase()
        let isFetchPurchasedExamPostsCalled = true
        mockRepository.isFetchPurchasedExamPostsCalled = isFetchPurchasedExamPostsCalled

        /// when
        let result = try await useCase.execute()

        /// then
        XCTAssertEqual(1, result.count)
        XCTAssertTrue(mockRepository.isFetchPurchasedExamPostsCalled)
    }

    func testFailure() async throws {
        /// given
        let mockRepository = MockExamPostRepository()
        DIContainer.shared.register(type: ExamPostRepository.self,
                                    mockRepository)
        let useCase = DefaultFetchPurchasedExamPostsUseCase()
        let isFetchPurchasedExamPostsCalled = false
        mockRepository.isFetchPurchasedExamPostsCalled = isFetchPurchasedExamPostsCalled

        /// when
        let result = try await useCase.execute()

        /// then
        XCTAssertEqual(0, result.count)
        XCTAssertFalse(mockRepository.isFetchPurchasedExamPostsCalled)
    }
}
