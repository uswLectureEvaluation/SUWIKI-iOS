//
//  SignUpUseCaseTests.swift
//  DomainTests
//
//  Created by 한지석 on 5/7/24.
//

import XCTest
@testable import Domain

final class SignUpUseCaseTests: XCTestCase, UserTestsProtocol {

    typealias UseCaseType = DefaultSignUpUseCase
    var useCase: DefaultSignUpUseCase!
    var repository: MockUserRepository!

    override func setUpWithError() throws {
        repository = MockUserRepository()
        useCase = DefaultSignUpUseCase(repository: repository)
    }

    func testSuccess() async throws {
        repository.expectedResult = true
        let result = try await useCase.execute(id: "id", password: "pwd", email: "email")
        XCTAssertTrue(result)
    }

    func testFailure() async throws {
        repository.expectedResult = false
        let result = try await useCase.execute(id: "id", password: "pwd", email: "email")
        XCTAssertFalse(result)
    }
}
