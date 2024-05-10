//
//  SearchLectureUseCaseTests.swift
//  DomainTests
//
//  Created by 한지석 on 5/10/24.
//

import XCTest
@testable import DIContainer
@testable import Domain

final class SearchLectureUseCaseTests: XCTestCase, TestsProtocol {
    func testSuccess() async throws {
        let mockRepository = MockLectureRepository()
        DIContainer.shared.register(
            type: LectureRepository.self,
            mockRepository
        )
        let useCase = DefaultSearchLectureUseCase()
        let isSearchCalled = true
        mockRepository.isSearchCalled = isSearchCalled
        let searchText = "SearchTest"
        let option: LectureOption = .lectureHoneyAvg

        let result = try await useCase.excute(
            searchText: searchText,
            option: option,
            page: 1,
            major: ""
        )

        XCTAssertEqual(searchText, mockRepository.searchText)
        XCTAssertEqual(option, mockRepository.lectureOption)
        XCTAssertEqual(1, result.count)
        XCTAssertTrue(mockRepository.isSearchCalled)
    }

    func testFailure() async throws {
        let mockRepository = MockLectureRepository()
        DIContainer.shared.register(
            type: LectureRepository.self,
            mockRepository
        )
        let useCase = DefaultSearchLectureUseCase()
        let isSearchCalled = false
        mockRepository.isSearchCalled = isSearchCalled
        let searchText = "SearchTest"
        let option: LectureOption = .lectureHoneyAvg

        let result = try await useCase.excute(
            searchText: searchText,
            option: option,
            page: 1,
            major: ""
        )

        XCTAssertNotEqual(searchText, mockRepository.searchText)
        XCTAssertNotEqual(option, mockRepository.lectureOption)
        XCTAssertEqual(0, result.count)
        XCTAssertFalse(mockRepository.isSearchCalled)
    }
}
