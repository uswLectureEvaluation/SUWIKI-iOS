//
//  DTO+ExamPostResponse.swift
//  SUWIKI
//
//  Created by 한지석 on 3/1/24.
//

import Foundation

extension DTO {
    struct ExamPostResponse: Decodable {
        /// 글 ID
        let id: Int
        /// 수강 학기(2023-1)
        let selectedSemester: String
        /// 시험 정보(교재, PPT)
        let examInfo: String
        /// 시험 타입(기말고사)
        let examType: String
        /// 난이도(쉬움, 어려움)
        let examDifficulty: String
        /// 시험 정보 내용
        let content: String
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
