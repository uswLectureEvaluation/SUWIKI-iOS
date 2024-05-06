//
//  DTO+Lecture.swift
//  SUWIKI
//
//  Created by 한지석 on 1/24/24.
//

import Foundation

import Domain

extension DTO {
    public struct LectureResponse: Codable, Identifiable {
        /// 강의 ID
        public let id: Int
        /// 강의년도 + 학기 "2021-1, 2022-1"
        public let semesterList: String
        /// 교수명
        public let professor: String
        /// 개설학과
        public let majorType: String
        /// 이수구분
        public let lectureType: String
        /// 강의 이름
        public let lectureName: String
        /// 강의 평가 지수 평균
        public let lectureTotalAvg: Float
        /// 강의 평가 만족도 지수 평균
        public let lectureSatisfactionAvg: Float
        /// 강의 평가 꿀강 지수 평균
        public let lectureHoneyAvg: Float
        /// 강의 평가 배움 지수 평균
        public let lectureLearningAvg: Float

        public init(
            id: Int,
            semesterList: String,
            professor: String,
            majorType: String,
            lectureType: String,
            lectureName: String,
            lectureTotalAvg: Float,
            lectureSatisfactionAvg: Float,
            lectureHoneyAvg: Float,
            lectureLearningAvg: Float
        ) {
            self.id = id
            self.semesterList = semesterList
            self.professor = professor
            self.majorType = majorType
            self.lectureType = lectureType
            self.lectureName = lectureName
            self.lectureTotalAvg = lectureTotalAvg
            self.lectureSatisfactionAvg = lectureSatisfactionAvg
            self.lectureHoneyAvg = lectureHoneyAvg
            self.lectureLearningAvg = lectureLearningAvg
        }
    }
}

extension DTO.LectureResponse {
    var entity: Lecture {
        Lecture(id: id,
                name: lectureName,
                major: majorType,
                professor: professor,
                lectureType: lectureType,
                lectureTotalAvg: Double(lectureTotalAvg))
    }
}
