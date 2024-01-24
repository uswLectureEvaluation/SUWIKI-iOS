//
//  DTO+Lecture.swift
//  SUWIKI
//
//  Created by 한지석 on 1/24/24.
//

import Foundation

extension DTO {
    struct Lecture: Codable, Identifiable {
        /// 강의 ID
        let id: Int
        /// 강의년도 + 학기 "2021-1, 2022-1"
        let semesterList: String
        /// 교수명
        let professor: String
        /// 개설학과
        let majorType: String
        /// 이수구분
        let lectureType: String
        /// 강의 이름
        let lectureName: String

        /// 강의 평가 지수 평균
        let lectureTotalAvg: Double
        /// 강의 평가 만족도 지수 평균
        let lectureSatisfactionAvg: Double
        /// 강의 평가 꿀강 지수 평균
        let lectureHoneyAvg: Double
        /// 강의 평가 배움 지수 평균
        let lectureLearningAvg: Double
    }
}


