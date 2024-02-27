//
//  FetchEvaluatePostsUseCase.swift
//  SUWIKI
//
//  Created by 한지석 on 2/27/24.
//

import Foundation

protocol FetchEvaluatePostsUseCase {
    func execute(
        lectureId: Int,
        page: Int
    ) async throws -> [EvaluatePost]
}

final class DefaultFetchEvaluatePostsUseCase: FetchEvaluatePostsUseCase {

    @Inject var repository: EvaluatePostRepository

    func execute(
        lectureId: Int,
        page: Int
    ) async throws -> [EvaluatePost] {
        try await repository.fetch(lectureId: lectureId, page: page)
    }

}
