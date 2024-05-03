//
//  DetailLecture.swift
//  SUWIKI
//
//  Created by 한지석 on 2/5/24.
//

import Foundation

/// 강의평가 상세
public struct DetailLecture: Identifiable {
    /// 강의 ID
    public let id: Int
    /// 강의명
    public let name: String
    /// 전공
    public let major: String
    /// 교수명
    public let professor: String
    /// 개설 학기
    public let semester: String
    /// 이수구분
    public let lectureType: String
    /// 평점
    public let lectureTotalAvg: Double
    /// 강의 평가 만족도 지수
    public let lectureSatisfactionAvg: Double
    /// 강의 평가 꿀강 지수
    public let lectureHoneyAvg: Double
    /// 강의 평가 배움 지수
    public let lectureLearningAvg: Double
    /// 학점 지수
    public let lectureDifficultyAvg: Int
    /// 팀플 지수
    public let lectureTeamAvg: Int
    /// 과제 지수
    public let lectureHomeworkAvg: Int
    
    public init(
        id: Int,
        name: String,
        major: String,
        professor: String,
        semester: String,
        lectureType: String,
        lectureTotalAvg: Double,
        lectureSatisfactionAvg: Double, 
        lectureHoneyAvg: Double,
        lectureLearningAvg: Double, 
        lectureDifficultyAvg: Int,
        lectureTeamAvg: Int,
        lectureHomeworkAvg: Int
    ) {
        self.id = id
        self.name = name
        self.major = major
        self.professor = professor
        self.semester = semester
        self.lectureType = lectureType
        self.lectureTotalAvg = lectureTotalAvg
        self.lectureSatisfactionAvg = lectureSatisfactionAvg
        self.lectureHoneyAvg = lectureHoneyAvg
        self.lectureLearningAvg = lectureLearningAvg
        self.lectureDifficultyAvg = lectureDifficultyAvg
        self.lectureTeamAvg = lectureTeamAvg
        self.lectureHomeworkAvg = lectureHomeworkAvg
    }
}

extension DetailLecture {
    static public let mockdata = DetailLecture(id: 0,
                                               name: "강의명",
                                               major: "개설학과",
                                               professor: "교수명",
                                               semester: "2021-2, 2022-1",
                                               lectureType: "이수구분",
                                               lectureTotalAvg: 3.5,
                                               lectureSatisfactionAvg: 0.0,
                                               lectureHoneyAvg: 0.0,
                                               lectureLearningAvg: 0.0,
                                               lectureDifficultyAvg: 0,
                                               lectureTeamAvg: 0,
                                               lectureHomeworkAvg: 0)
}
