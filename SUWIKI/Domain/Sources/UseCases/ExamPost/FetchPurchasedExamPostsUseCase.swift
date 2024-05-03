//
//  FetchPurchasedExamPostsUseCase.swift
//  SUWIKI
//
//  Created by 한지석 on 4/8/24.
//

import Foundation

import DIContainer

public protocol FetchPurchasedExamPostsUseCase {
    func execute() async throws -> [PurchasedPost]
}

public final class DefaultFetchPurchasedExamPostsUseCase: FetchPurchasedExamPostsUseCase {
    @Inject private var repository: ExamPostRepository

    public init() { }

    public func execute() async throws -> [PurchasedPost] {
        return try await repository.fetchPurchasedExamPosts()
    }
}
