//
//  FetchUserEvaluationPostsUseCase.swift
//  SUWIKI
//
//  Created by 한지석 on 4/4/24.
//

import Foundation

import DIContainer

protocol FetchUserEvaluationPostsUseCase {
    func execute() async throws -> [UserEvaluationPost]
}

final class DefaultFetchUserEvaluationPostUseCase: FetchUserEvaluationPostsUseCase {
    @Inject var repository: EvaluationPostRepository

    func execute() async throws -> [UserEvaluationPost] {
        return try await repository.fetchUserPosts()
    }
}
