//
//  AddCourseViewModel.swift
//  SUWIKI
//
//  Created by 한지석 on 2023/06/19.
//

import Foundation

final class AddCourseViewModel {
    let coreDataManager = CoreDataManager.shared
    var course: [Course] = []
    
    func getCourse() {
        course = coreDataManager.getCourseFromCoreData()
        print("count - \(course.count)")
        for i in 0..<100 {
            print(course[i].classification)
            print(course[i].courseDay)
            print(course[i].courseName)
            print(course[i].startTime)
            print(course[i].endTime)
            print(course[i].major)
            print(course[i].roomName)
            print(course[i].professor)
        }
    }
    
}
