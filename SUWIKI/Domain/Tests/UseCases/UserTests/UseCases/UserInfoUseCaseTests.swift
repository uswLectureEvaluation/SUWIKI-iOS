//
//  UserInfoUseCaseTests.swift
//  DomainTests
//
//  Created by 한지석 on 5/7/24.
//

import XCTest
@testable import DIContainer
@testable import Domain

final class UserInfoUseCaseTests: XCTestCase, UserTestsProtocol {

    typealias UseCaseType = DefaultUserInfoUseCase
    var useCase: DefaultUserInfoUseCase!
    var repository: MockUserRepository!

    override func setUpWithError() throws {
        repository = MockUserRepository()
        DIContainer.shared.register(type: UserRepository.self,
                                    repository)
        useCase = DefaultUserInfoUseCase()
    }

    func testSuccess() async throws {
        repository.expectedResult = true
        let result = try await useCase.execute()
        XCTAssertTrue(result.id == "id", "유저 정보 가져오기 성공")
    }

    func testFailure() async throws {
        repository.expectedResult = false
        let result = try await useCase.execute()
        XCTAssertFalse(result.id == "id", "유저 정보 가져오기 실패")
    }
}
