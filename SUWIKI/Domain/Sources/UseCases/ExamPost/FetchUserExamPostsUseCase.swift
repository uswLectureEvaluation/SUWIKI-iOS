//
//  FetchUserExamPostsUseCase.swift
//  SUWIKI
//
//  Created by 한지석 on 4/5/24.
//

import Foundation

import DIContainer

public protocol FetchUserExamPostsUseCase {
    func execute() async throws -> [UserExamPost]
}

public final class DefaultFetchUserExamPostsUseCase: FetchUserExamPostsUseCase {
    @Inject private var repository: ExamPostRepository

    public init() { }

    public func execute() async throws -> [UserExamPost] {
        return try await repository.fetchUserPosts()
    }
}
