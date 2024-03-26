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

    func write(
        id: Int,
        lectureName: String,
        professor: String,
        selectedSemester: String,
        satisfaction: Double,
        learning: Double,
        honey: Double,
        team: Int,
        difficulty: Int,
        homework: Int,
        content: String
    ) async throws -> Bool {
        let apiTarget = APITarget.EvaluatePost.writeEvaluatePost(
            DTO.WriteEvaluatePostRequest(
                lectureInfo: DTO.WriteEvaluatePostRequest.LectureInfo(lectureId: id),
                post: DTO.WriteEvaluatePostRequest.Post(lectureName: lectureName,
                                                        professor: professor,
                                                        selectedSemester: selectedSemester,
                                                        satisfaction: Float(satisfaction),
                                                        learning: Float(learning),
                                                        honey: Float(honey),
                                                        team: team,
                                                        difficulty: difficulty,
                                                        homework: homework,
                                                        content: content))
        )
        if let statusCode = try await APIProvider.request(target: apiTarget) {
            if statusCode == 200 {
                return true
            } else {
                return false
            }
        } else {
            return false
        }
    }
}
