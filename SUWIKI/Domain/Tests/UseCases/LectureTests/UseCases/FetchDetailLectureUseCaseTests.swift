//
//  FetchDetailLectureUseCaseTests.swift
//  DomainTests
//
//  Created by 한지석 on 5/10/24.
//

import XCTest
@testable import DIContainer
@testable import Domain

final class FetchDetailLectureUseCaseTests: XCTestCase, TestsProtocol {
    func testSuccess() async throws {
        let mockRepository = MockLectureRepository()
        DIContainer.shared.register(
            type: LectureRepository.self,
            mockRepository
        )
        let useCase = DefaultFetchDetailLectureUseCase()
        let isFetchDetailCalled = true
        mockRepository.isFetchDetailCalled = isFetchDetailCalled
        let id = 220

        let result = try await useCase.excute(id: id)
        
        XCTAssertEqual(id, mockRepository.id)
        XCTAssertEqual(id, result.id)
        XCTAssertTrue(mockRepository.isFetchDetailCalled)
    }
    
    func testFailure() async throws {
        let mockRepository = MockLectureRepository()
        DIContainer.shared.register(
            type: LectureRepository.self,
            mockRepository
        )
        let useCase = DefaultFetchDetailLectureUseCase()
        let isFetchDetailCalled = false
        mockRepository.isFetchDetailCalled = isFetchDetailCalled
        let id = 220

        let result = try await useCase.excute(id: id)

        XCTAssertNotEqual(id, mockRepository.id)
        XCTAssertNotEqual(id, result.id)
        XCTAssertFalse(mockRepository.isFetchDetailCalled)
    }
}
