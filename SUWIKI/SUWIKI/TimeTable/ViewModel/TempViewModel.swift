//
//  TempViewModel.swift
//  SUWIKI
//
//  Created by 한지석 on 2023/06/10.
//

import UIKit

import CoreData
import Firebase

final class TempViewModel {
    private let ref = Database.database().reference()
    var tempArray: [tempCourse] = []
    
    func check() { // 파베 데이터 가져오기
        ref.getData { error, data in
            guard let snapshot = data else { return }
            for child in snapshot.children {
                let childSnapshot = child as? DataSnapshot
                guard let value = childSnapshot?.value as? NSDictionary else {
                    print("value return")
                    return
                }
                let course = tempCourse(classNum: value["classNum"] as? Int ?? 0,
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
                self.check2(inputCourse: course)
            }
        }
    }
//    func check1() {
//        var temp1: [tempCourse] = []
//        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
//        let context = appDelegate.persistentContainer.viewContext
//        let request = NSFetchRequest<NSManagedObject>(entityName: "Course")
//        print("어디고")
//        do {
//            if let loadCourse = try context.fetch(request) as? [tempCourse] {
//                temp1 = loadCourse
//                print(temp1)
//            }
//        } catch {
//            print("실패")
//        }
//
//    }
//    func check1() { // 저장된 데이터 불러오기
//        var temp1: [Course] = []
//        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
//        let context = appDelegate.persistentContainer.viewContext
////        guard let entity = NSEntityDescription.entity(forEntityName: "Course", in: context) else { return }
//        if let loadCourse = try? context.fetch(Course.fetchRequest()) {
//            temp1 = loadCourse
//            print(temp1.count)
//        }
//   
//    }
    
    func check2(inputCourse: tempCourse) { // 데이터 저장하기
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        guard let entity = NSEntityDescription.entity(forEntityName: "Course", in: context) else {
            print("entity")
            return }
        let course = NSManagedObject(entity: entity, insertInto: context)
        course.setValue(inputCourse.classNum, forKey: "classNum")
        course.setValue(inputCourse.classification, forKey: "classification")
        course.setValue(inputCourse.courseDay, forKey: "courseDay")
        course.setValue(inputCourse.courseName, forKey: "courseName")
        course.setValue(inputCourse.credit, forKey: "credit")
        course.setValue(inputCourse.startTime, forKey: "startTime")
        course.setValue(inputCourse.endTime, forKey: "endTime")
        course.setValue(inputCourse.major, forKey: "major")
        course.setValue(inputCourse.num, forKey: "num")
        course.setValue(inputCourse.professor, forKey: "professor")
        course.setValue(inputCourse.roomName, forKey: "roomName")
        print("bye")
        try? context.save()
    }
}

struct tempCourse {
    var classNum: Int
    var classification: String
    var courseDay: String
    var courseName: String
    var credit: Int
    var startTime: String
    var endTime: String
    var major: String
    var num: Int
    var professor: String
    var roomName: String
}
