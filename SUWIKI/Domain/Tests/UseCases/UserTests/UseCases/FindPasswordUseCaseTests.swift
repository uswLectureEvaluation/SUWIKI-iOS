//
//  FindPasswordUseCaseTests.swift
//  DomainTests
//
//  Created by 한지석 on 5/7/24.
//

import XCTest
@testable import DIContainer
@testable import Domain

final class FindPasswordUseCaseTests: XCTestCase, UserTestsProtocol {

    typealias UseCaseType = DefaultFindPasswordUseCase
    var useCase: DefaultFindPasswordUseCase!
    var repository: MockUserRepository!

    override func setUpWithError() throws {
        repository = MockUserRepository()
        DIContainer.shared.register(type: UserRepository.self,
                                    repository)
        useCase = DefaultFindPasswordUseCase()
    }

    func testSuccess() async throws {
        repository.expectedResult = true
        let result = try await useCase.execute(id: "id", email: "email")
        XCTAssertTrue(result)
    }

    func testFailure() async throws {
        repository.expectedResult = false
        let result = try await useCase.execute(id: "id", email: "email")
        XCTAssertFalse(result)
    }
}
