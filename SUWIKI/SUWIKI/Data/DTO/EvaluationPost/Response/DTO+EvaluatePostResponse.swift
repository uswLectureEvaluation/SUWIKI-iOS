//
//  DTO+FetchEvaluatePostsResponse.swift
//  SUWIKI
//
//  Created by 한지석 on 2/8/24.
//

import Foundation

extension DTO {
    struct EvaluatePostResponse: Decodable {
        /// 글 ID
        let id: Int
        /// 수강 학기
        let selectedSemester: String
        /// 총 평균
        let totalAvg: Float
        /// 만족도
        let satisfaction: Float
        /// 배움지수
        let learning: Float
        /// 꿀강 지수
        let honey: Float
        /// 조별모임 유무(없음 == 0, 있음 == 1)
        let team: Int
        /// 학점 잘주는가?(잘줌 == 0, 보통 == 1, 까다로움 == 2)
        let difficulty: Int
        /// 과제양(없음 == 0, 보통 == 1, 많음 == 2)
        let homework: Int
        /// 작성글
        let content: String
    }
}

extension DTO.EvaluatePostResponse {
    var entity: EvaluationPost {
        EvaluationPost(
            id: id,
            selectedSemester: selectedSemester,
            totalAvarage: Double(totalAvg),
            content: content
        )
    }
}
