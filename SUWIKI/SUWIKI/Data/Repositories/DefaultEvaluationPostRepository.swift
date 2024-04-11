//
//  DefaultEvaluatePostRepository.swift
//  SUWIKI
//
//  Created by 한지석 on 2/27/24.
//

import Foundation

final class DefaultEvaluationPostRepository: EvaluationPostRepository {

    func fetch(
        lectureId: Int,
        page: Int
    ) async throws -> Evaluation {
        let apiTarget = APITarget.EvaluationPost.fetchEvaluationPosts(
            DTO.FetchEvaluationPostRequest(
                lectureId: lectureId,
                page: page
            )
        )
        let dtoEvaluatePosts = try await APIProvider.request(DTO.FetchEvaluationPostsResponse.self,
                                                             target: apiTarget)
        return Evaluation(written: dtoEvaluatePosts.written,
                          posts: dtoEvaluatePosts.posts.map { $0.entity} )
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
        let apiTarget = APITarget.EvaluationPost.writeEvaluationPost(
            DTO.WriteEvaluationPostRequest(
                lectureInfo: DTO.WriteEvaluationPostRequest.LectureInfo(lectureId: id),
                post: DTO.WriteEvaluationPostRequest.Post(lectureName: lectureName,
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
        return try await APIProvider.request(target: apiTarget)
    }

    func fetchUserPosts() async throws -> [UserEvaluationPost] {
        let apiTarget = APITarget.EvaluationPost.fetchUserEvaluationPosts
        let value = try await APIProvider.request(DTO.FetchUserEvaluationPostsResponse.self,
                                                  target: apiTarget)
        return value.posts.map { $0.entity }
    }

    func update(
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
        let apiTarget = APITarget
            .EvaluationPost
            .updateEvaluationPost(
                DTO.UpdateEvaluationPostRequest(lectureInfo: DTO.UpdateEvaluationPostRequest.LectureInfo(evaluateIdx: id),
                                                post: DTO.UpdateEvaluationPostRequest.Post(selectedSemester: selectedSemester,
                                                                                           satisfaction: satisfaction,
                                                                                           learning: learning,
                                                                                           honey: honey,
                                                                                           team: team,
                                                                                           difficulty: difficulty,
                                                                                           homework: homework,
                                                                                           content: content)))
        return try await APIProvider.request(target: apiTarget)
    }

}
