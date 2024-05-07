//
//  CheckDuplicatedEmailUseCaseTests.swift
//  DomainTests
//
//  Created by 한지석 on 5/7/24.
//

import XCTest
@testable import Domain

final class CheckDuplicatedEmailUseCaseTests: XCTestCase, UserTestsProtocol {

    typealias UseCaseType = DefaultCheckDuplicatedEmailUseCase
    var useCase: DefaultCheckDuplicatedEmailUseCase!
    var repository: MockUserRepository!

    override func setUpWithError() throws {
        repository = MockUserRepository()
        useCase = DefaultCheckDuplicatedEmailUseCase(repository: repository)
    }

    func testSuccess() async throws {
        repository.expectedResult = true
        let result = try await useCase.execute(email: "email")
        XCTAssertTrue(result)
    }

    func testFailure() async throws {
        repository.expectedResult = false
        let result = try await useCase.execute(email: "email")
        XCTAssertFalse(result)
    }
}
