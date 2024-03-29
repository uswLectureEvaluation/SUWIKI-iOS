//
//  DTO+WriteExamPostRequest.swift
//  SUWIKI
//
//  Created by 한지석 on 3/29/24.
//

import Foundation

extension DTO {
    struct WriteExamPostRequest: Encodable {
        let lectureInfo: LectureInfo
        let post: Post
    }
}

extension DTO.WriteExamPostRequest {
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
