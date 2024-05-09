//
//  WriteExamPostUseCaseTests.swift
//  DomainTests
//
//  Created by 한지석 on 5/9/24.
//

import XCTest
@testable import DIContainer
@testable import Domain

final class WriteExamPostUseCaseTests: XCTestCase, ExamPostTestsProtocol {
    func testSuccess() async throws {
        // given
        let mockRepository = MockExamPostRepository()
        DIContainer.shared.register(type: ExamPostRepository.self,
                                    mockRepository)
        let useCase = DefaultWriteExamPostUseCase()
        let isWriteCalled = true
        mockRepository.isWriteCalled = isWriteCalled

        // when
        let result = try await useCase.execute(id: 1,
                                               lectureName: "테스트 강의",
                                               professor: "홍길동",
                                               selectedSemester: "2024 1학기", 
                                               examInfo: "중간고사",
                                               examType: "서술형",
                                               examDifficulty: "어려움",
                                               content: "테스트 내용")

        // then
        XCTAssertTrue(result == isWriteCalled)
        XCTAssertEqual(1, mockRepository.id)
    }

    func testFailure() async throws {
        // given
        let mockRepository = MockExamPostRepository()
        DIContainer.shared.register(type: ExamPostRepository.self,
                                    mockRepository)
        let useCase = DefaultWriteExamPostUseCase()
        let isWriteCalled = false
        mockRepository.isWriteCalled = isWriteCalled

        // when
        let result = try await useCase.execute(id: 1,
                                               lectureName: "테스트 강의",
                                               professor: "홍길동",
                                               selectedSemester: "2024 1학기",
                                               examInfo: "중간고사",
                                               examType: "서술형",
                                               examDifficulty: "어려움",
                                               content: "테스트 내용")

        // then
        XCTAssertFalse(result)
        XCTAssertEqual(1, mockRepository.id)
    }

}
