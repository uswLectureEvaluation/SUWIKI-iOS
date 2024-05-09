//
//  PurchaseExamPostUseCaseTests.swift
//  DomainTests
//
//  Created by 한지석 on 5/9/24.
//

import XCTest
@testable import DIContainer
@testable import Domain

final class PurchaseExamPostUseCaseTests: XCTestCase, ExamPostTestsProtocol {
    func testSuccess() async throws {
        let mockRepository = MockExamPostRepository()
        DIContainer.shared.register(type: ExamPostRepository.self,
                                    mockRepository)
        let useCase = DefaultPurchaseExamPostUseCase()
        let isPurchaseCalled = true
        mockRepository.isPurchaseCalled = isPurchaseCalled

        let result = try await useCase.execute(id: 1)

        XCTAssertEqual(isPurchaseCalled, result)
        XCTAssertTrue(mockRepository.isPurchaseCalled)
    }
    
    func testFailure() async throws {
        let mockRepository = MockExamPostRepository()
        DIContainer.shared.register(type: ExamPostRepository.self,
                                    mockRepository)
        let useCase = DefaultPurchaseExamPostUseCase()
        let isPurchaseCalled = false
        mockRepository.isPurchaseCalled = isPurchaseCalled

        let result = try await useCase.execute(id: 1)

        XCTAssertEqual(isPurchaseCalled, result)
        XCTAssertFalse(mockRepository.isPurchaseCalled)
    }
}
