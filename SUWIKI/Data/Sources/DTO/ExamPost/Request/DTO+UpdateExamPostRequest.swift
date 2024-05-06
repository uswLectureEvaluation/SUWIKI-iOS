//
//  DTO+UpdateExamPostRequest.swift
//  SUWIKI
//
//  Created by 한지석 on 4/5/24.
//

import Foundation

extension DTO {
    public struct UpdateExamPostRequest: Encodable {
        public let lectureInfo: LectureInfo
        public let post: Post

        public init(
            lectureInfo: LectureInfo,
            post: Post
        ) {
            self.lectureInfo = lectureInfo
            self.post = post
        }
    }
}

extension DTO.UpdateExamPostRequest {
    public struct LectureInfo: Encodable {
        public let examIdx: Int

        public init(examIdx: Int) {
            self.examIdx = examIdx
        }
    }
    public struct Post: Encodable {
        /// 선택학기
        public let selectedSemester: String
        /// 교재, 피피티 등
        public let examInfo: String
        /// 중간고사 - 기말고사
        public let examType: String
        /// 쉬움, 보통, 어려움
        public let examDifficulty: String
        /// 유저가 작성한 내용
        public let content: String

        public init(
            selectedSemester: String,
            examInfo: String,
            examType: String,
            examDifficulty: String,
            content: String
        ) {
            self.selectedSemester = selectedSemester
            self.examInfo = examInfo
            self.examType = examType
            self.examDifficulty = examDifficulty
            self.content = content
        }
    }
}
