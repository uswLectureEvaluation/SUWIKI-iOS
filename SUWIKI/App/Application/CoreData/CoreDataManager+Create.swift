//
//  CoreDataManager+Create.swift
//  SUWIKI
//
//  Created by 한지석 on 2023/07/31.
//

import Foundation
//import CoreData
//
//extension CoreDataManager {
//
//    /// func test1SaveFirebaseCourse: 저장 속도 테스트를 위한 코드입니다. 저장속도 약 60초 소요됩니다. 저장 에러도 발생하는 코드입니다.
//    func test1SaveFirebaseCourse(item: [String: Any]) throws {
//        guard let entity = NSEntityDescription.entity(forEntityName: "FirebaseCourse", in: context) else {
//            throw CoreDataError.entityError
//        }
//        let firebaseCourseEntity = NSManagedObject(entity: entity, insertInto: context)
//        firebaseCourseEntity.setValue(item["classification"] ?? "", forKey: "classification")
//        firebaseCourseEntity.setValue(item["roomName"] ?? "", forKey: "roomName")
//        firebaseCourseEntity.setValue(item["professor"] ?? "", forKey: "professor")
//        firebaseCourseEntity.setValue(item["num"] ?? 0, forKey: "num")
//        firebaseCourseEntity.setValue(item["courseName"] ?? "", forKey: "courseName")
//        firebaseCourseEntity.setValue(item["major"] ?? "", forKey: "major")
//        firebaseCourseEntity.setValue(item["credit"] ?? 0, forKey: "credit")
//        firebaseCourseEntity.setValue(item["classNum"] ?? "", forKey: "classNum")
//        firebaseCourseEntity.setValue(item["courseDay"] ?? "", forKey: "courseDay")
//        firebaseCourseEntity.setValue(item["startTime"] ?? "", forKey: "startTime")
//        firebaseCourseEntity.setValue(item["endTime"] ?? "", forKey: "endTime")
//        do {
//            try context.save()
//        } catch {
//            print("@Log - \(error.localizedDescription)")
//        }
//    }
//
//    /// func test2SaveFirebaseCourse: 저장 속도 테스트를 위한 코드입니다. 저장속도 약 2초 ~ 3초 소요됩니다.
//    func test2SaveFirebaseCourse(course: [[String: Any]]) throws {
//        guard let entity = NSEntityDescription.entity(forEntityName: "FirebaseCourse", in: context) else {
//            throw CoreDataError.entityError
//        }
//        for item in course {
//            let firebaseCourseEntity = NSManagedObject(entity: entity, insertInto: context)
//            firebaseCourseEntity.setValue(item["classification"] ?? "", forKey: "classification")
//            firebaseCourseEntity.setValue(item["roomName"] ?? "", forKey: "roomName")
//            firebaseCourseEntity.setValue(item["professor"] ?? "", forKey: "professor")
//            firebaseCourseEntity.setValue(item["num"] ?? 0, forKey: "num")
//            firebaseCourseEntity.setValue(item["courseName"] ?? "", forKey: "courseName")
//            firebaseCourseEntity.setValue(item["major"] ?? "", forKey: "major")
//            firebaseCourseEntity.setValue(item["credit"] ?? 0, forKey: "credit")
//            firebaseCourseEntity.setValue(item["classNum"] ?? "", forKey: "classNum")
//            firebaseCourseEntity.setValue(item["courseDay"] ?? "", forKey: "courseDay")
//            firebaseCourseEntity.setValue(item["startTime"] ?? "", forKey: "startTime")
//            firebaseCourseEntity.setValue(item["endTime"] ?? "", forKey: "endTime")
//        }
//        do {
//            try context.save()
//        } catch {
//            print("@Log - \(error.localizedDescription)")
//        }
//    }
//}
