//
//  DTO+FetchUserEvaluationPosts.swift
//  SUWIKI
//
//  Created by 한지석 on 4/4/24.
//

import Foundation

extension DTO {
    struct FetchUserEvaluationPostsResponse: Decodable {
        let posts: [UserEvaluationPostResponse]
        let statusCode: Int?
        let message: String?
    }
}

extension DTO.FetchUserEvaluationPostsResponse {
    struct UserEvaluationPostResponse: Decodable {
        let id: Int
        let lectureName: String
        let professor: String
        let majorType: String
        let selectedSemester: String
        let semester: String
        let totalAvg: Double
        let satisfaction: Double
        let learning: Double
        let honey: Double
        let team: Int
        let difficulty: Int
        let homework: Int
        let content: String

        var entity: UserEvaluationPost {
            UserEvaluationPost(id: id,
                               name: lectureName,
                               selectedSemester: selectedSemester,
                               semester: semester,
                               lectureTotalAvg: totalAvg,
                               lectureSatisfactionAvg: satisfaction,
                               lectureHoneyAvg: honey,
                               lectureLearningAvg: learning,
                               lectureDifficultyAvg: difficulty,
                               lectureTeamAvg: team,
                               lectureHomeworkAvg: homework,
                               content: content)
        }
    }
}
