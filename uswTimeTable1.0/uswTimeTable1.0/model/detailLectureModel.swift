//
//  detailLectureModel.swift
//  uswTimeTable1.0
//
//  Created by 한지석 on 2022/04/07.
//

import Foundation

struct detailLecture {
    
    let id: Int
    let semester: String //강의년도 + 학기 (ex) "2021-1,2022-1" )
    let professor: String //교수이름
    let lectureType: String //이수구분
    let lectureName: String //강의이름
    let lectureTotalAvg: String //강의 평가 평균 지수 (평균값)
    let lectureSatisfactionAvg: String //강의 평가 만족도 지수 (평균값)
    let lectureHoneyAvg: String //강의 평가 꿀강 지수 (평균값)
    let lectureLearningAvg: String //강의 평가 배움 지수 (평균값)
    let lectureTeamAvg: Float
    let lectureDifficultyAvg: Float
    let lectureHomeworkAvg: Float
    
}

struct detailEvaluation {

    var expanded: Bool
    let id: Int
    let semester: String
    let totalAvg: String
    let satisfaction: String
    let learning: String
    let honey: String
    let team: String // 조별모임 유무(없음 == 0, 있음 == 1)
    let difficulty: String //학점 잘주는가? (까다로움 == 0, 보통 == 1, 학점느님 ==2)
    let homework: String //과제양 (없음 ==0, 보통 == 1, 많음 == 2)
    let content: String
    
}

struct detailExam {
    let id: Int
    let semester: String
    let examInfo: String
    let examDifficulty: String
    let content: String
}

struct cellData {
    
}
