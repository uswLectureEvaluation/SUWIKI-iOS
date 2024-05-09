//
//  ChangePasswordUseCaseTests.swift
//  DomainTests
//
//  Created by 한지석 on 5/7/24.
//

import XCTest
@testable import DIContainer
@testable import Domain

final class ChangePasswordUseCaseTests: XCTestCase, UserTestsProtocol {

    typealias UseCaseType = DefaultChangePasswordUseCase
    var useCase: DefaultChangePasswordUseCase!
    var repository: MockUserRepository!

    override func setUpWithError() throws {
        repository = MockUserRepository()
        DIContainer.shared.register(type: UserRepository.self,
                                    repository)
        useCase = DefaultChangePasswordUseCase()
    }

    func testSuccess() async throws {
        repository.expectedResult = true
        let result = try await useCase.execute(current: "current", new: "new")
        XCTAssertTrue(result)
    }

    func testFailure() async throws {
        repository.expectedResult = false
        let result = try await useCase.execute(current: "current", new: "new")
        XCTAssertFalse(result)
    }
}
