//
//  CheckDuplicatedEmailUseCaseTests.swift
//  DomainTests
//
//  Created by 한지석 on 5/7/24.
//

import XCTest
@testable import DIContainer
@testable import Domain

final class CheckDuplicatedEmailUseCaseTests: XCTestCase, UserTestsProtocol {

    typealias UseCaseType = DefaultCheckDuplicatedEmailUseCase
    var useCase: DefaultCheckDuplicatedEmailUseCase!
    var repository: MockUserRepository!

    override func setUpWithError() throws {
        repository = MockUserRepository()
        DIContainer.shared.register(type: UserRepository.self,
                                    repository)
        useCase = DefaultCheckDuplicatedEmailUseCase()
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
