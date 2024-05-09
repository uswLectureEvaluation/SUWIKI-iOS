//
//  CheckDuplicatedIdUseCaseTests.swift
//  DomainTests
//
//  Created by 한지석 on 5/7/24.
//

import XCTest
@testable import Domain

final class CheckDuplicatedIdUseCaseTests: XCTestCase, UserTestsProtocol {

    typealias UseCaseType = DefaultCheckDuplicatedIdUseCase
    var useCase: DefaultCheckDuplicatedIdUseCase!
    var repository: MockUserRepository!

    override func setUpWithError() throws {
        repository = MockUserRepository()
        useCase = DefaultCheckDuplicatedIdUseCase(repository: repository)
    }

    func testSuccess() async throws {
        repository.expectedResult = true
        let result = try await useCase.execute(id: "id")
        XCTAssertTrue(result)
    }

    func testFailure() async throws {
        repository.expectedResult = false
        let result = try await useCase.execute(id: "id")
        XCTAssertFalse(result)
    }
}
