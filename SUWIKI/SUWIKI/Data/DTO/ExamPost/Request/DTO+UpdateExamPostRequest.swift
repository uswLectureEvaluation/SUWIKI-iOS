//
//  DTO+UpdateExamPostRequest.swift
//  SUWIKI
//
//  Created by 한지석 on 4/5/24.
//

import Foundation

extension DTO {
    struct UpdateExamPostRequest: Encodable {
        let lectureInfo: LectureInfo
        let post: Post
    }
}

extension DTO.UpdateExamPostRequest {
    struct LectureInfo: Encodable {
        let examIdx: Int
    }
    struct Post: Encodable {
        /// 선택학기
        let selectedSemester: String
        /// 교재, 피피티 등
        let examInfo: String
        /// 중간고사 - 기말고사
        let examType: String
        /// 쉬움, 보통, 어려움
        let examDifficulty: String
        /// 유저가 작성한 내용
        let content: String
    }
}
