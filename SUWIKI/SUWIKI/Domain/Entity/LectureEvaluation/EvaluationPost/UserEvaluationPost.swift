//
//  UserEvaluationPost.swift
//  SUWIKI
//
//  Created by 한지석 on 4/4/24.
//

import Foundation

struct UserEvaluationPost: Identifiable, Hashable {
    /// 강의평가 ID
    let id: Int
    /// 강의 이름
    let name: String
    /// 교수
    let professor: String
    /// 유저 선택 학기
    let selectedSemester: String
    /// 개설학기
    let semester: String
    /// 강의평가 종합 지수
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
    /// 강의평가 내용
    let content: String
}
