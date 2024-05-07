//
//  WithDrawUseCaseTests.swift
//  DomainTests
//
//  Created by 한지석 on 5/7/24.
//

import XCTest
@testable import Domain

final class WithDrawUseCaseTests: XCTestCase {

    var useCase: DefaultWithDrawUseCase!
    var mockRepository: MockUserRepository!

    override func setUpWithError() throws {
        mockRepository = MockUserRepository()
        useCase = DefaultWithDrawUseCase(repository: mockRepository)
    }

    func testSignInSuccess() async throws {
        mockRepository.expectedResult = true
        let result = try await useCase.execute(id: "testId", password: "pwd1232123")
        XCTAssertTrue(result, "비밀번호 찾기 성공")
    }

    func testSignInFailure() async throws {
        mockRepository.expectedResult = false
        let result = try await useCase.execute(id: "testId", password: "pwd123123")
        XCTAssertFalse(result, "비밀번호 찾기 실패")
    }

}
