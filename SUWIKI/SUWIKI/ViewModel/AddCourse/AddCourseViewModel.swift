//
//  AddCourseViewModel.swift
//  SUWIKI
//
//  Created by 한지석 on 2023/08/22.
//

import Foundation

final class AddCourseViewModel {
    
    let addCourseManager = AddCourseManager()
    var timetableColorNumber = Int.random(in: 0...20)
    var firebaseCourse: FirebaseCourse
    
    
    init(firebaseCourse: FirebaseCourse) {
        self.firebaseCourse = firebaseCourse
    }
    
    func changeTimetableColor() {
        var changeNumber = Int.random(in: 0...20)
        while changeNumber == timetableColorNumber {
            changeNumber = Int.random(in: 0...20)
        }
        timetableColorNumber = changeNumber
    }
    
    func saveCourse() -> Bool {
        var isDuplicated = false
        guard let courseName = firebaseCourse.courseName,
              let roomName = firebaseCourse.roomName,
              let professor = firebaseCourse.professor,
              let startTime = firebaseCourse.startTime,
              let endTime = firebaseCourse.endTime,
              let courseDay = firebaseCourse.courseDay
        else { return true }
        let course = TimetableCourse(courseId: UUID().uuidString,
                                     courseName: courseName,
                                     roomName: roomName,
                                     professor: professor,
                                     courseDay: dayToInt(courseDay: courseDay),
                                     startTime: startTime,
                                     endTime: endTime,
                                     timetableColor: timetableColorNumber)
        
        if roomName.split(separator: " ").count > 1 { // 1. 음악109(화1,2 수3,4)
            isDuplicated = addCourseManager.saveCourse(newCourse: course, duplicateCase: .differentTime)
        } else if roomName.split(separator: "),").count > 1 { // 2. 음악109(화1,2),음악110(수1,2)
            isDuplicated = addCourseManager.saveCourse(newCourse: course, duplicateCase: .differentPlace)
        } else {
            isDuplicated = addCourseManager.saveCourse(newCourse: course, duplicateCase: .normal)
        }
        
        return isDuplicated
    }
    
    func dayToInt(courseDay: String) -> Int {
        var dayToString = 0
        switch courseDay {
        case "월":
            dayToString = 1
        case "화":
            dayToString = 2
        case "수":
            dayToString = 3
        case "목":
            dayToString = 4
        case "금":
            dayToString = 5
        default:
            break
        }
        return dayToString
    }
    
    
}
