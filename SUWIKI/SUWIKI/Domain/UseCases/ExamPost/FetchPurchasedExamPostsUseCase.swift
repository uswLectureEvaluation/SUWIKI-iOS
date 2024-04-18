//
//  FetchPurchasedExamPostsUseCase.swift
//  SUWIKI
//
//  Created by 한지석 on 4/8/24.
//

import Foundation

import DIContainer

protocol FetchPurchasedExamPostsUseCase {
    func execute() async throws -> [PurchasedPost]
}

final class DefaultFetchPurchasedExamPostsUseCase: FetchPurchasedExamPostsUseCase {
    @Inject var repository: ExamPostRepository

    func execute() async throws -> [PurchasedPost] {
        return try await repository.fetchPurchasedExamPosts()
    }
}
