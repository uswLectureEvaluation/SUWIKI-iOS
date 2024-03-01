//
//  DefaultEvaluatePostRepository.swift
//  SUWIKI
//
//  Created by 한지석 on 2/27/24.
//

import Foundation

final class DefaultEvaluatePostRepository: EvaluatePostRepository {
    func fetch(
        lectureId: Int, 
        page: Int
    ) async throws -> [EvaluatePost] {
        let apiTarget = APITarget.EvaluatePost.fetchEvaluatePosts(
            DTO.FetchEvaluatePostRequest(
                lectureId: lectureId,
                page: page
            )
        )
        let dtoEvaluatePosts = try await APIProvider.request(DTO.FetchEvaluatePostsResponse.self,
                                                             target: apiTarget)
        return dtoEvaluatePosts.posts.map { $0.entity }
    }
}
