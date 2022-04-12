//
//  evaluationWriteModel.swift
//  uswTimeTable1.0
//
//  Created by 한지석 on 2022/04/12.
//

import Foundation

struct evaluationWrite {
    
    let lectureName: String
    let professor: String
    let semester: String
    let honey: Float
    let learning: Float
    let satisfaction: Float
    let team: Int
    let difficulty: Int
    let homework: Int
    let content: String
    
}

struct btnClickedType{
    
    struct teamWorkBtnType{
        var noTeamWork: Bool
        var haveTeamWork: Bool
    }
    
    struct homeworkType{
        var noHomework: Bool
        var usuallyHomework: Bool
        var manyHomework: Bool
    }
    
    struct difficultyType{
        var easyDifficulty: Bool
        var usuallDifficulty: Bool
        var hardDifficulty: Bool
    }
    
}
