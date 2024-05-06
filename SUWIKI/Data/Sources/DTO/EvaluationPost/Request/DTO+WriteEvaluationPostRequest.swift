//
//  DTO+WriteEvaluatePostRequest.swift
//  SUWIKI
//
//  Created by 한지석 on 3/4/24.
//

import Foundation

extension DTO {
    public struct WriteEvaluationPostRequest: Encodable {
        /// 강의 ID
        public let lectureInfo: LectureInfo
        public let post: Post
    }
}

extension DTO.WriteEvaluationPostRequest {
    public struct LectureInfo: Encodable {
        public let lectureId: Int
    }
    public struct Post: Encodable {
        /// 강의명
        public let lectureName: String
        /// 교수
        public let professor: String
        /// 선택학기
        public let selectedSemester: String
        /// 만족도
        public let satisfaction: Float
        /// 배움지수
        public let learning: Float
        /// 꿀강지수
        public let honey: Float
        /// 팀플 유무(1 == 유, 0 == 무)
        public let team: Int
        /// 학점 주는 정도(2 == 쉬움, 1 == 보통, 0 == 쉬움)
        public let difficulty: Int
        /// 과제양(2 == 많음, 1 == 보통, 0 == 보통)
        public let homework: Int
        /// 유저가 작성한 내용
        public let content: String

        public init(
            lectureName: String,
            professor: String,
            selectedSemester: String,
            satisfaction: Float,
            learning: Float,
            honey: Float,
            team: Int,
            difficulty: Int,
            homework: Int,
            content: String
        ) {
            self.lectureName = lectureName
            self.professor = professor
            self.selectedSemester = selectedSemester
            self.satisfaction = satisfaction
            self.learning = learning
            self.honey = honey
            self.team = team
            self.difficulty = difficulty
            self.homework = homework
            self.content = content
        }
    }
}
