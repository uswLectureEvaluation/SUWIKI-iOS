//
//  DTO+DetailLectureResponse.swift
//  SUWIKI
//
//  Created by 한지석 on 2/5/24.
//

import Foundation

extension DTO {
    struct DetailLectureResponse: Codable {
        /// 강의 ID
        let id: Int
        /// 해당 강의 년도 + 학기 -> "2021-1,2022-1"
        let semesterList: String
        /// 교수명
        let professor: String
        /// 개설 학과
        let majorType: String
        /// 이수 구분
        let lectureType: String
        /// 강의명
        let lectureName: String
        /// 강의평가 평균 지수
        let lectureTotalAvg: Float
        /// 강의평가 만족도 지수
        let lectureSatisfactionAvg: Float
        /// 강의평가 꿀강 지수
        let lectureHoneyAvg: Float
        /// 강의평가 배움 지수
        let lectureLearningAvg: Float
        /// 강의평가 팀플 지수
        let lectureTeamAvg: Int
        /// 강의평가 난이도 지수
        let lectureDifficultyAvg: Int
        /// 강의평가 과제 지수
        let lectureHomeworkAvg: Int
    }
}

extension DTO.DetailLectureResponse {
    var entity: DetailLecture {
        DetailLecture(id: id,
                      name: lectureName,
                      major: majorType,
                      professor: professor,
                      lectureType: lectureType,
                      lectureTotalAvg: Double(lectureTotalAvg),
                      lectureSatisfactionAvg: Double(lectureSatisfactionAvg),
                      lectureHoneyAvg: Double(lectureHoneyAvg),
                      lectureLearningAvg: Double(lectureLearningAvg),
                      lectureDifficultyAvg: lectureDifficultyAvg,
                      lectureTeamAvg: lectureTeamAvg,
                      lectureHomeworkAvg: lectureHomeworkAvg)
    }
}

//
//extension DTO.LectureResponse {
//    var entity: Lecture {
//        Lecture(id: id,
//                name: lectureName,
//                major: majorType,
//                professor: professor,
//                lectureType: lectureType,
//                lectureTotalAvg: Double(lectureTotalAvg))
//    }
//}
