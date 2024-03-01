//
//  DetailLecture.swift
//  SUWIKI
//
//  Created by 한지석 on 2/5/24.
//

import Foundation

/// 강의평가 상세
struct DetailLecture {
    /// 강의 ID
    let id: Int
    /// 강의명
    let name: String
    /// 전공
    let major: String
    /// 교수명
    let professor: String
    /// 이수구분
    let lectureType: String
    /// 평점
    let lectureTotalAvg: Double
    /// 강의 평가 만족도 지수
    let lectureSatisfactionAvg: Double
    /// 강의 평가 꿀강 지수
    let lectureHoneyAvg: Double
    /// 강의 평가 배움 지수
    let lectureLearningAvg: Double
    /// 학점 지수
    let lectureDifficultyAvg: Int
    /// 팀플 지수
    let lectureTeamAvg: Int
    /// 과제 지수
    let lectureHomeworkAvg: Int
}

extension DetailLecture {
    static let mockdata = DetailLecture(id: 0,
                                        name: "강의명",
                                        major: "개설학과",
                                        professor: "교수명",
                                        lectureType: "이수구분",
                                        lectureTotalAvg: 3.5,
                                        lectureSatisfactionAvg: 0.0,
                                        lectureHoneyAvg: 0.0,
                                        lectureLearningAvg: 0.0,
                                        lectureDifficultyAvg: 0,
                                        lectureTeamAvg: 0,
                                        lectureHomeworkAvg: 0)
}
