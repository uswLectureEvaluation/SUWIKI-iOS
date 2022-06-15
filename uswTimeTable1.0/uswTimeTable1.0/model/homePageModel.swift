//
//  homePageModel.swift
//  uswTimeTable1.0
//
//  Created by 한지석 on 2022/03/31.
//

import Foundation
 
struct homePageData{
    
    let id: Int
    let semesterList: String //강의년도 + 학기 (ex) "2021-1,2022-1" )
    let professor: String //교수이름
    let majorType: String
    let lectureType: String //이수구분
    let lectureName: String //강의이름
    let lectureTotalAvg: String //강의 평가 평균 지수 (평균값)
    let lectureSatisfactionAvg: String //강의 평가 만족도 지수 (평균값)
    let lectureHoneyAvg: String //강의 평가 꿀강 지수 (평균값)
    let lectureLearningAvg: String //강의 평가 배움 지수 (평균값)
    
    
}
