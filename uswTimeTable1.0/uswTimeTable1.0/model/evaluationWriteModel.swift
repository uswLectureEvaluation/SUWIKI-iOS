//
//  evaluationWriteModel.swift
//  uswTimeTable1.0
//
//  Created by 한지석 on 2022/04/12.
//

import Foundation

struct btnClickedType{
    
    struct teamWorkType{
        var noTeamWork: Bool = false
        var haveTeamWork: Bool = false
        var teamWorkPoint: Int = 3
        
        mutating func checkPoint(no: Bool, have: Bool){
            if no == true {
                teamWorkPoint = 0
            } else if have == true {
                teamWorkPoint = 1
            } else {
                teamWorkPoint = 3
            }
        }
    }
    
    struct homeworkType{
        var noHomework: Bool = false
        var usuallyHomework: Bool = false
        var manyHomework: Bool = false
        var homeworkPoint: Int = 3
        
        mutating func checkPoint(no: Bool, usually: Bool, many: Bool){
            if no == true {
                homeworkPoint = 0
            } else if usually == true {
                homeworkPoint = 1
            } else if many == true {
                homeworkPoint = 2
            } else {
                homeworkPoint = 3
            }
        }
        
    }
    
    struct difficultyType{
        var easyDifficulty: Bool = false
        var normalDifficulty: Bool = false
        var hardDifficulty: Bool = false
        var difficultyPoint: Int = 3
        
        mutating func checkPoint(easy: Bool, normal: Bool, hard: Bool){
            if easy == true {
                difficultyPoint = 0
            } else if normal == true {
                difficultyPoint = 1
            } else if hard == true {
                difficultyPoint = 2
            } else {
                difficultyPoint = 3
            }
        }
    }
    

}

