//
//  UserTestsProtocol.swift
//  DomainTests
//
//  Created by 한지석 on 5/7/24.
//

import Foundation

protocol UserTestsProtocol {
    associatedtype UseCaseType
    var useCase: UseCaseType! { get }
    var repository: MockUserRepository! { get }

    func testSuccess() async throws
    func testFailure() async throws
}
