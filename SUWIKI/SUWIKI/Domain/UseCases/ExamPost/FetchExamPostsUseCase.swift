//
//  FetchExamPostsUseCase.swift
//  SUWIKI
//
//  Created by 한지석 on 3/1/24.
//

import Foundation

protocol FetchExamPostsUseCase {
    func execute(
        id: Int,
        page: Int
    ) async throws -> ExamPostInfo
}

final class DefaultFetchExamPostUseCase: FetchExamPostsUseCase {
    @Inject var repository: ExamPostRepository

    func execute(id: Int, page: Int) async throws -> ExamPostInfo {
        try await repository.fetch(id: id, page: page)
    }
}
