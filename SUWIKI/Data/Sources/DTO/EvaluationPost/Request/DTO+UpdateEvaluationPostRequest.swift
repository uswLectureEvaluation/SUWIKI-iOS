//
//  DTO+ModifyEvaluationPostRequest.swift
//  SUWIKI
//
//  Created by 한지석 on 4/5/24.
//

import Foundation

extension DTO {
    struct UpdateEvaluationPostRequest: Encodable {
        let lectureInfo: LectureInfo
        let post: Post
    }
}

extension DTO.UpdateEvaluationPostRequest {
    struct LectureInfo: Encodable {
        let evaluateIdx: Int
    }

    struct Post: Encodable {
        let selectedSemester: String
        let satisfaction: Double
        let learning: Double
        let honey: Double
        let team: Int
        let difficulty: Int
        let homework: Int
        let content: String
    }
}
