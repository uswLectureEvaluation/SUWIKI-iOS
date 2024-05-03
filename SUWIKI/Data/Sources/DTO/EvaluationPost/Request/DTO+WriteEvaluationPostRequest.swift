//
//  DTO+WriteEvaluatePostRequest.swift
//  SUWIKI
//
//  Created by 한지석 on 3/4/24.
//

import Foundation

extension DTO {
    struct WriteEvaluationPostRequest: Encodable {
        /// 강의 ID
        let lectureInfo: LectureInfo
        let post: Post
    }
}

extension DTO.WriteEvaluationPostRequest {
    struct LectureInfo: Encodable {
        let lectureId: Int
    }
    struct Post: Encodable {
        /// 강의명
        let lectureName: String
        /// 교수
        let professor: String
        /// 선택학기
        let selectedSemester: String
        /// 만족도
        let satisfaction: Float
        /// 배움지수
        let learning: Float
        /// 꿀강지수
        let honey: Float
        /// 팀플 유무(1 == 유, 0 == 무)
        let team: Int
        /// 학점 주는 정도(2 == 쉬움, 1 == 보통, 0 == 쉬움)
        let difficulty: Int
        /// 과제양(2 == 많음, 1 == 보통, 0 == 보통)
        let homework: Int
        /// 유저가 작성한 내용
        let content: String
    }
}
