//
//  FetchLectureUseCaseTests.swift
//  DomainTests
//
//  Created by 한지석 on 5/10/24.
//

import XCTest
@testable import DIContainer
@testable import Domain

final class FetchLectureUseCaseTests: XCTestCase, TestsProtocol {
    func testSuccess() async throws {
        /// given
        let mockRepository = MockLectureRepository()
        DIContainer.shared.register(
            type: LectureRepository.self,
            mockRepository
        )
        let useCase = DefaultFetchLectureUseCase()
        let isFetchCalled = true
        mockRepository.isFetchCalled = isFetchCalled
        /// when
        let option: LectureOption = .lectureHoneyAvg
        let result = try await useCase.excute(
            option: option,
            page: 0,
            major: ""
        )
        /// then
        XCTAssertEqual(option, mockRepository.lectureOption)
        XCTAssertEqual(1, result.count)
        XCTAssertTrue(mockRepository.isFetchCalled)
    }

    func testSatisfactionOption() async throws {
        /// given
        let mockRepository = MockLectureRepository()
        DIContainer.shared.register(
            type: LectureRepository.self,
            mockRepository
        )
        let useCase = DefaultFetchLectureUseCase()
        let isFetchCalled = true
        mockRepository.isFetchCalled = isFetchCalled
        /// when
        let option: LectureOption = .lectureSatisfactionAvg
        let result = try await useCase.excute(
            option: option,
            page: 0,
            major: ""
        )
        /// then
        XCTAssertEqual(option, mockRepository.lectureOption)
        XCTAssertEqual(1, result.count)
        XCTAssertTrue(mockRepository.isFetchCalled)
    }

    func testFailure() async throws {
        /// given
        let mockRepository = MockLectureRepository()
        DIContainer.shared.register(
            type: LectureRepository.self,
            mockRepository
        )
        let useCase = DefaultFetchLectureUseCase()
        let isFetchCalled = false
        mockRepository.isFetchCalled = isFetchCalled
        /// when
        let option: LectureOption = .lectureTotalAvg
        let result = try await useCase.excute(
            option: option,
            page: 0,
            major: ""
        )
        /// then
        XCTAssertNotEqual(option, mockRepository.lectureOption)
        XCTAssertEqual(0, result.count)
        XCTAssertFalse(mockRepository.isFetchCalled)
    }
}
