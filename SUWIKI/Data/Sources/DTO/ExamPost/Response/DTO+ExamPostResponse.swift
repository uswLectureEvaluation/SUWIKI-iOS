//
//  DTO+ExamPostResponse.swift
//  SUWIKI
//
//  Created by 한지석 on 3/1/24.
//

import Foundation

import Domain

extension DTO {
    public struct ExamPostResponse: Decodable {
        /// 글 ID
        public let id: Int
        /// 수강 학기(2023-1)
        public let selectedSemester: String
        /// 시험 정보(교재, PPT)
        public let examInfo: String
        /// 시험 타입(기말고사)
        public let examType: String
        /// 난이도(쉬움, 어려움)
        public let examDifficulty: String
        /// 시험 정보 내용
        public let content: String

        public init(
            id: Int,
            selectedSemester: String,
            examInfo: String,
            examType: String,
            examDifficulty: String,
            content: String
        ) {
            self.id = id
            self.selectedSemester = selectedSemester
            self.examInfo = examInfo
            self.examType = examType
            self.examDifficulty = examDifficulty
            self.content = content
        }
    }
}

extension DTO.ExamPostResponse {
    var entity: ExamPost {
        ExamPost(id: id,
                 semester: selectedSemester,
                 examType: examType,
                 sourceOfExam: examInfo,
                 difficulty: examDifficulty,
                 content: content)
    }
}
