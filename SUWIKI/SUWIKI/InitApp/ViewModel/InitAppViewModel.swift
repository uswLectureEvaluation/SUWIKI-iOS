//
//  InitAppViewModel.swift
//  SUWIKI
//
//  Created by 한지석 on 2023/06/14.
//

import Foundation

import Firebase
import CoreData

class InitAppViewModel {
    
    let coreDataManager = CoreDataManager.shared
    private let ref = Database.database().reference()
    
    func fetchFirebaseCourse(completionHandler: @escaping (([FirebaseCourse]?) -> Void)) {
        ref.getData { error, data in
            var firebaseCourse: [FirebaseCourse] = []
            guard let snapshot = data else { return }
            for child in snapshot.children {
                let childSnapshot = child as? DataSnapshot
                guard let value = childSnapshot?.value as? NSDictionary else {
                    completionHandler(nil)
                    return
                }
                let course = FirebaseCourse(classNum: value["classNum"] as? Int ?? 0,
                                            classification: value["classification"] as? String ?? "",
                                            courseDay: value["courseDay"] as? String ?? "",
                                            courseName: value["courseName"] as? String ?? "",
                                            credit: value["credit"] as? Int ?? 0,
                                            startTime: value["startTime"] as? String ?? "",
                                            endTime: value["endTime"] as? String ?? "",
                                            major: value["major"] as? String ?? "",
                                            num: value["num"] as? Int ?? 0,
                                            professor: value["professor"] as? String ?? "",
                                            roomName: value["roomName"] as? String ?? "")
                firebaseCourse.append(course)
            }
            completionHandler(firebaseCourse)
        }
    }
    
    func saveCourseToCoreData(course: [FirebaseCourse]) { // 데이터 저장하기
        coreDataManager.saveCourseData(course: course)
        checkCoreDataCount()
    }
    
    func checkCoreDataCount() { // 저장된 데이터 불러오기 - 시간표 추가 시 필요할듯한데..
        var temp: [Course] = []
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        if let loadCourse = try? context.fetch(Course.fetchRequest()) {
            temp = loadCourse
            print(temp.count)
        }
    }
    
}
