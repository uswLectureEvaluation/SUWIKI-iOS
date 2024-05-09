//
//  SignUpUseCaseTests.swift
//  DomainTests
//
//  Created by 한지석 on 5/7/24.
//

import XCTest
@testable import DIContainer
@testable import Domain

final class SignUpUseCaseTests: XCTestCase, UserTestsProtocol {

    typealias UseCaseType = DefaultSignUpUseCase
    var useCase: DefaultSignUpUseCase!
    var repository: MockUserRepository!

    override func setUpWithError() throws {
        repository = MockUserRepository()
        DIContainer.shared.register(type: UserRepository.self,
                                    repository)
        useCase = DefaultSignUpUseCase()
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
