//
//  FetchAnnouncementUseCaseTests.swift
//  DomainTests
//
//  Created by 한지석 on 5/27/24.
//

import XCTest
@testable import DIContainer
@testable import Domain

final class FetchAnnouncementUseCaseTests: XCTestCase, TestsProtocol {
    func testSuccess() async throws {
        let mockRepository = MockNoticeRepository()
        DIContainer.shared.register(
            type: NoticeRepository.self,
            mockRepository
        )
        let useCase = DefaultFetchAnnouncementUseCase()
        let isFetchCalled = true
        mockRepository.isFetchCalled = isFetchCalled

        let result = try await useCase.execute()

        XCTAssertEqual(isFetchCalled, mockRepository.isFetchCalled)
        XCTAssertTrue(mockRepository.isFetchCalled)
        XCTAssertEqual(1, result.count)
    }
    
    func testFailure() async throws {
        let mockRepository = MockNoticeRepository()
        DIContainer.shared.register(
            type: NoticeRepository.self,
            mockRepository
        )
        let useCase = DefaultFetchAnnouncementUseCase()
        let isFetchCalled = false
        mockRepository.isFetchCalled = isFetchCalled

        let result = try await useCase.execute()

        XCTAssertEqual(isFetchCalled, mockRepository.isFetchCalled)
        XCTAssertFalse(mockRepository.isFetchCalled)
        XCTAssertEqual(0, result.count)
    }
}
