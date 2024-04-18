//
//  FetchUserExamPostsUseCase.swift
//  SUWIKI
//
//  Created by 한지석 on 4/5/24.
//

import Foundation

import DIContainer

protocol FetchUserExamPostsUseCase {
    func execute() async throws -> [UserExamPost]
}

final class DefaultFetchUserExamPostsUseCase: FetchUserExamPostsUseCase {

    @Inject var repository: ExamPostRepository

    func execute() async throws -> [UserExamPost] {
        return try await repository.fetchUserPosts()
    }
}
