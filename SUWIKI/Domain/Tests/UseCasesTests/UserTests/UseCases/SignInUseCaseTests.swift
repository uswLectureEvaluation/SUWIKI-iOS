//
//  SearchLectureUseCaseTests.swift
//  DomainTests
//
//  Created by 한지석 on 5/7/24.
//

import XCTest
@testable import Domain

final class SignInUseCaseTests: XCTestCase {

    var useCase: DefaultSignInUseCase!
    var mockRepository: MockLectureRepository!

    override func setUpWithError() throws {
        mockRepository = MockLectureRepository()
        useCase = DefaultSignInUseCase(repository: mockRepository)
    }

    func testSignInSuccess() async throws {
        mockRepository.expectedResult = true
        let result = try await useCase.excute(id: "testId", password: "pwd1232123")
        XCTAssertTrue(result, "비밀번호 찾기 성공")
    }

    func testSignInFailure() async throws {
        mockRepository.expectedResult = false
        let result = try await useCase.excute(id: "testId", password: "pwd123123")
        XCTAssertFalse(result, "비밀번호 찾기 실패")
    }

}
