//
//  MockUserRepository.swift
//  DomainTests
//
//  Created by 한지석 on 5/7/24.
//

import Foundation

import Domain

final class MockUserRepository: UserRepository {

    var expectedResult: Bool?

    func login(id: String, password: String) async throws -> Bool {
        if let expectedResult = expectedResult {
            return expectedResult
        } else {
            throw NSError(domain: "mockError", code: 0, userInfo: nil)
        }
    }

    func join(id: String, password: String, email: String) async throws -> Bool {
        if let expectedResult = expectedResult {
            return expectedResult
        } else {
            throw NSError(domain: "mockError", code: 0, userInfo: nil)
        }
    }

    func checkDuplicatedId(id: String) async throws -> Bool {
        if let expectedResult = expectedResult {
            return expectedResult
        } else {
            throw NSError(domain: "mockError", code: 0, userInfo: nil)
        }
    }

    func checkDuplicatedEmail(email: String) async throws -> Bool {
        if let expectedResult = expectedResult {
            return expectedResult
        } else {
            throw NSError(domain: "mockError", code: 0, userInfo: nil)
        }
    }

    func findId(email: String) async throws -> Bool {
        if let expectedResult = expectedResult {
            return expectedResult
        } else {
            throw NSError(domain: "mockError", code: 0, userInfo: nil)
        }
    }

    func findPassword(id: String, email: String) async throws -> Bool {
        if let expectedResult = expectedResult {
            return expectedResult
        } else {
            throw NSError(domain: "mockError", code: 0, userInfo: nil)
        }
    }

    func userInfo() async throws -> UserInfo {
        if let expectedResult = expectedResult {
            if expectedResult {
                return UserInfo(id: "id",
                                email: "email",
                                point: 100,
                                writtenEvaluationPosts: 100,
                                writtenExamPosts: 100,
                                purchasedExamPosts: 100)
            } else {
                return UserInfo(id: "x",
                                email: "x",
                                point: 0,
                                writtenEvaluationPosts: 0,
                                writtenExamPosts: 0,
                                purchasedExamPosts: 0)
            }
        } else {
            throw NSError(domain: "mockError", code: 0, userInfo: nil)
        }
    }

    func changePassword(current: String, new: String) async throws -> Bool {
        if let expectedResult = expectedResult {
            return expectedResult
        } else {
            throw NSError(domain: "mockError", code: 0, userInfo: nil)
        }
    }

    func withDraw(id: String, password: String) async throws -> Bool {
        if let expectedResult = expectedResult {
            return expectedResult
        } else {
            throw NSError(domain: "mockError", code: 0, userInfo: nil)
        }
    }


}

