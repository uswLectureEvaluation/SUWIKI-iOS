//
//  FetchEvaluatePostsUseCase.swift
//  SUWIKI
//
//  Created by 한지석 on 2/27/24.
//

import Foundation

protocol FetchEvaluationPostsUseCase {
    func execute(
        lectureId: Int,
        page: Int
    ) async throws -> [EvaluationPost]
}

final class DefaultFetchEvaluationPostsUseCase: FetchEvaluationPostsUseCase {

    @Inject var repository: EvaluationPostRepository

    func execute(
        lectureId: Int,
        page: Int
    ) async throws -> [EvaluationPost] {
        try await repository.fetch(lectureId: lectureId, page: page)
    }

}
