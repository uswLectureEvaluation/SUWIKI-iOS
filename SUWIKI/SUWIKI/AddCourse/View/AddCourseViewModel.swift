//
//  AddCourseViewModel.swift
//  SUWIKI
//
//  Created by 한지석 on 2023/06/19.
//

import Foundation

final class AddCourseViewModel {
    
    let coreDataManager = CoreDataManager.shared
    var course: FirebaseCourse
    
    init(course: FirebaseCourse) {
        self.course = course
    }
    
    //MARK: Output
    
    var classification: String {
        course.classification ?? ""
    }
    
    var courseDay: String {
        course.courseDay ?? ""
    }
    
    var courseName: String {
        course.courseName ?? ""
    }
    
    var startTime: String {
        course.startTime ?? ""
    }
    
    var endTime: String {
        course.endTime ?? ""
    }
    
    var major: String {
        "\(String(describing: course.major ?? ""))⎪"
    }
    
    var professor: String {
        "\(String(describing: course.professor ?? ""))⎪"
    }
    
    var credit: String {
        "\(course.credit)학점"
    }
    
    var roomName: String {
        course.roomName ?? ""
    } 
    
    func getCourse() {
//        course = coreDataManager.getCourseFromCoreData()
//        print("count - \(course.count)")
//        for i in 0..<100 {
//            print(course[i].classification)
//            print(course[i].courseDay)
//            print(course[i].courseName)
//            print(course[i].startTime)
//            print(course[i].endTime)
//            print(course[i].major)
//            print(course[i].roomName)
//            print(course[i].professor)
//        }
    }
    
}
