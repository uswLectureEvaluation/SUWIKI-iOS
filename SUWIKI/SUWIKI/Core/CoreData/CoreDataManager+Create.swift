//
//  CoreDataManager+Create.swift
//  SUWIKI
//
//  Created by 한지석 on 2023/07/31.
//

import Foundation
import CoreData

extension CoreDataManager {

    /// func addTimetable : 새로운 시간표를 생성합니다.
    /// - Parameter name : 시간표 명
    /// - Parameter semester : 학기
    func addTimeTable(name: String, semester: String) {
        guard let entity = NSEntityDescription.entity(forEntityName: "Timetable", in: context) else { return }
        let timetableEntity = NSManagedObject(entity: entity, insertInto: context)
        checkMainThread()
        let id = UUID().uuidString
        timetableEntity.setValue(id,  forKey: "id")
        timetableEntity.setValue(name, forKey: "name")
        timetableEntity.setValue(semester, forKey: "semester")
        UserDefaults.shared.set(id, forKey: "id")
        do {
            try context.save()
        } catch {
            print("@Log - \(error.localizedDescription)")
        }
    }

    /// func saveFirebaseCourse: 파이어베이스에 저장된 데이터를 코어데이터에 저장합니다. 저장속도 0.2 ~ 0.9초 소요
    /// - Parameter course : [[String: Any]]
    /// NSBatchInsertRequest Objects
    /// /// 새로운 학기의 강의를 업데이트할 경우 기존의 로컬에 있는 강의는 삭제하고 진행해야 함.
    func saveFirebaseCourse(course: [[String: Any]]) throws {
        try deleteFirebaseCourse()
        guard let entity = NSEntityDescription.entity(forEntityName: "FirebaseCourse", in: context) else {
            throw CoreDataError.entityError
        }
        checkMainThread()
        let batchInsertRequest = NSBatchInsertRequest(entity: entity, objects: course)
        if let fetchResult = try? context.execute(batchInsertRequest),
           let batchInsertResult = fetchResult as? NSBatchInsertResult,
           let success = batchInsertResult.result as? Bool, success {
            return
        }
        print(CoreDataError.batchInsertError.localizedDescription)
    }

    /// func saveTimetableCourse: 선택된 시간표에 강의를 저장합니다.
    /// - Parameter id : timetable id
    /// - Parameter course : 추가할 강의
    func saveCourse(id: String, course: TimetableCourse) throws {
        let fetchRequest = Timetable.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id)
        do {
            guard let timetable = try context.fetch(fetchRequest).first else {
                throw CoreDataError.fetchError
            }
            checkMainThread()
            let courseEntity = Course(context: context)
            courseEntity.courseId = course.courseId
            courseEntity.courseName = course.courseName
            courseEntity.roomName = course.roomName
            courseEntity.courseDay = Int16(course.courseDay)
            courseEntity.professor = course.professor
            courseEntity.startTime = course.startTime
            courseEntity.endTime = course.endTime
            courseEntity.timetableColor = Int16(course.timetableColor)
            timetable.addToCourses(courseEntity)
            try context.save()
        } catch {
            context.rollback()
            throw CoreDataError.saveError
        }
    }

    func saveTitle(id: String, title: String) throws {
        let fetchRequest = Timetable.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id)
        do {
            guard let timetable = try context.fetch(fetchRequest).first else {
                throw CoreDataError.fetchError
            }
            timetable.name = title
            try context.save()
        } catch {
            context.rollback()
            throw CoreDataError.saveError
        }
    }

    /// func test1SaveFirebaseCourse: 저장 속도 테스트를 위한 코드입니다. 저장속도 약 60초 소요됩니다. 저장 에러도 발생하는 코드입니다.
    func test1SaveFirebaseCourse(item: [String: Any]) throws {
        guard let entity = NSEntityDescription.entity(forEntityName: "FirebaseCourse", in: context) else {
            throw CoreDataError.entityError
        }
        let firebaseCourseEntity = NSManagedObject(entity: entity, insertInto: context)
        firebaseCourseEntity.setValue(item["classification"] ?? "", forKey: "classification")
        firebaseCourseEntity.setValue(item["roomName"] ?? "", forKey: "roomName")
        firebaseCourseEntity.setValue(item["professor"] ?? "", forKey: "professor")
        firebaseCourseEntity.setValue(item["num"] ?? 0, forKey: "num")
        firebaseCourseEntity.setValue(item["courseName"] ?? "", forKey: "courseName")
        firebaseCourseEntity.setValue(item["major"] ?? "", forKey: "major")
        firebaseCourseEntity.setValue(item["credit"] ?? 0, forKey: "credit")
        firebaseCourseEntity.setValue(item["classNum"] ?? "", forKey: "classNum")
        firebaseCourseEntity.setValue(item["courseDay"] ?? "", forKey: "courseDay")
        firebaseCourseEntity.setValue(item["startTime"] ?? "", forKey: "startTime")
        firebaseCourseEntity.setValue(item["endTime"] ?? "", forKey: "endTime")
        do {
            try context.save()
        } catch {
            print("@Log - \(error.localizedDescription)")
        }
    }

    /// func test2SaveFirebaseCourse: 저장 속도 테스트를 위한 코드입니다. 저장속도 약 2초 ~ 3초 소요됩니다.
    func test2SaveFirebaseCourse(course: [[String: Any]]) throws {
        guard let entity = NSEntityDescription.entity(forEntityName: "FirebaseCourse", in: context) else {
            throw CoreDataError.entityError
        }
        for item in course {
            let firebaseCourseEntity = NSManagedObject(entity: entity, insertInto: context)
            firebaseCourseEntity.setValue(item["classification"] ?? "", forKey: "classification")
            firebaseCourseEntity.setValue(item["roomName"] ?? "", forKey: "roomName")
            firebaseCourseEntity.setValue(item["professor"] ?? "", forKey: "professor")
            firebaseCourseEntity.setValue(item["num"] ?? 0, forKey: "num")
            firebaseCourseEntity.setValue(item["courseName"] ?? "", forKey: "courseName")
            firebaseCourseEntity.setValue(item["major"] ?? "", forKey: "major")
            firebaseCourseEntity.setValue(item["credit"] ?? 0, forKey: "credit")
            firebaseCourseEntity.setValue(item["classNum"] ?? "", forKey: "classNum")
            firebaseCourseEntity.setValue(item["courseDay"] ?? "", forKey: "courseDay")
            firebaseCourseEntity.setValue(item["startTime"] ?? "", forKey: "startTime")
            firebaseCourseEntity.setValue(item["endTime"] ?? "", forKey: "endTime")
        }
        do {
            try context.save()
        } catch {
            print("@Log - \(error.localizedDescription)")
        }
    }
}
