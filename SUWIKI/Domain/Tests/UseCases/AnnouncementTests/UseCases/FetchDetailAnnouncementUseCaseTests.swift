//
//  FetchDetailAnnouncementUseCaseTests.swift
//  DomainTests
//
//  Created by 한지석 on 5/27/24.
//

import XCTest
@testable import DIContainer
@testable import Domain

final class FetchDetailAnnouncementUseCaseTests: XCTestCase, TestsProtocol {
    func testSuccess() async throws {
        let mockRepository = MockNoticeRepository()
        DIContainer.shared.register(
            type: NoticeRepository.self,
            mockRepository
        )
        let useCase = DefaultFetchDetailAnnouncementUseCase()
        let isFetchDetailCalled = true
        mockRepository.isFetchDetailCalled = isFetchDetailCalled

        let result = try await useCase.execute(id: 1)

        XCTAssertEqual(isFetchDetailCalled, mockRepository.isFetchDetailCalled)
        XCTAssertEqual(1, result.id)
        XCTAssertTrue(mockRepository.isFetchDetailCalled)
    }
    
    func testFailure() async throws {
        let mockRepository = MockNoticeRepository()
        DIContainer.shared.register(
            type: NoticeRepository.self,
            mockRepository
        )
        let useCase = DefaultFetchDetailAnnouncementUseCase()
        let isFetchDetailCalled = false
        mockRepository.isFetchDetailCalled = isFetchDetailCalled

        let result = try await useCase.execute(id: 1)

        XCTAssertEqual(isFetchDetailCalled, mockRepository.isFetchDetailCalled)
        XCTAssertNotEqual(1, result.id)
        XCTAssertFalse(mockRepository.isFetchDetailCalled)
    }
}
