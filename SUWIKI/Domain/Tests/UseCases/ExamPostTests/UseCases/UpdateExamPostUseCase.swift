//
//  UpdateExamPostUseCase.swift
//  DomainTests
//
//  Created by 한지석 on 5/9/24.
//

import XCTest
@testable import DIContainer
@testable import Domain

final class UpdateExamPostUseCase: XCTestCase, ExamPostTestsProtocol {
    func testSuccess() async throws {
        let mockRepository = MockExamPostRepository()
        DIContainer.shared.register(type: ExamPostRepository.self,
                                    mockRepository)
        let useCase = DefaultUpdateExamPostUseCase()
        let isUpdateCalled = true
        mockRepository.isUpdateCalled = isUpdateCalled

        let result = try await useCase.execute(id: 1,
                                               selectedSemester: "",
                                               examInfo: "",
                                               examType: "",
                                               examDifficulty: "",
                                               content: "")

        XCTAssertEqual(isUpdateCalled, result)
        XCTAssertTrue(mockRepository.isUpdateCalled)
        XCTAssertTrue(result)
    }

    func testFailure() async throws {
        let mockRepository = MockExamPostRepository()
        DIContainer.shared.register(type: ExamPostRepository.self,
                                    mockRepository)
        let useCase = DefaultUpdateExamPostUseCase()
        let isUpdateCalled = false
        mockRepository.isUpdateCalled = isUpdateCalled

        let result = try await useCase.execute(id: 1,
                                               selectedSemester: "",
                                               examInfo: "",
                                               examType: "",
                                               examDifficulty: "",
                                               content: "")

        XCTAssertEqual(isUpdateCalled, result)
        XCTAssertFalse(mockRepository.isUpdateCalled)
        XCTAssertFalse(result)
    }
}
