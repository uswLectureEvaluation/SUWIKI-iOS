//
//  FetchExamPostsUseCase.swift
//  SUWIKI
//
//  Created by 한지석 on 3/1/24.
//

import Foundation

import DIContainer

protocol FetchExamPostsUseCase {
    func execute(
        id: Int,
        page: Int
    ) async throws -> Exam
}

final class DefaultFetchExamPostUseCase: FetchExamPostsUseCase {
    @Inject var repository: ExamPostRepository

    func execute(id: Int, page: Int) async throws -> Exam {
        try await repository.fetch(id: id, page: page)
    }
}
