//
//  DefaultExamRepository.swift
//  SUWIKI
//
//  Created by 한지석 on 3/1/24.
//

import Foundation

final class DefaultExamPostRepository: ExamPostRepository {

    func fetch(id: Int, page: Int) async throws -> ExamPostInfo {
        let apiTarget = APITarget.ExamPost.fetchExamPosts(
            DTO.FetchExamPostsRequest(
                lectureId: id, page: page
            )
        )
        let dtoExamInfo = try await APIProvider.request(DTO.FetchExamPostsResponse.self, target: apiTarget)
        return ExamPostInfo(posts: dtoExamInfo.posts.map { $0.entity },
                            isPurchased: dtoExamInfo.canRead,
                            isWritten: dtoExamInfo.written,
                            isExamPostsExists: dtoExamInfo.examDataExist)
    }

}
