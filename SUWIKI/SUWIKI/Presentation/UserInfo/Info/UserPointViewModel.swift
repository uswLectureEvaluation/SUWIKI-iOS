//
//  UserPointViewModel.swift
//  SUWIKI
//
//  Created by 한지석 on 4/8/24.
//

import Foundation

final class UserPointViewModel: ObservableObject {

    @Inject var useCase: FetchPurchasedExamPostsUseCase

    let point: Int
    let writtenEvaluationPosts: Int
    let writtenExamPosts: Int
    let purchasedExamPosts: Int
    @Published var purchasedPosts: [PurchasedPost] = []

    init(
        point: Int,
        writtenEvaluationPosts: Int,
        writtenExamPosts: Int,
        purchasedExamPosts: Int
    ) {
        self.point = point
        self.writtenEvaluationPosts = writtenEvaluationPosts
        self.writtenExamPosts = writtenExamPosts
        self.purchasedExamPosts = purchasedExamPosts
        Task {
            let posts = try await useCase.execute()
            await MainActor.run {
                self.purchasedPosts = posts
            }
        }
    }
}
