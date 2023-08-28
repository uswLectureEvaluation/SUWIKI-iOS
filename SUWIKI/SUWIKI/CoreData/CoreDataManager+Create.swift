//
//  CoreDataManager+Create.swift
//  SUWIKI
//
//  Created by 한지석 on 2023/07/31.
//

import Foundation
import CoreData

extension CoreDataManager {
    
    /// func saveTimetable : 새로운 시간표를 생성합니다.
    /// - Parameter name : 시간표 명
    /// - Parameter semester : 학기
    func saveTimetable(name: String, semester: String) {
        guard let context = context else { return }
        guard let entity = NSEntityDescription.entity(forEntityName: "Timetable", in: context) else { return }
        let timetableEntity = NSManagedObject(entity: entity, insertInto: context)
        let id = UUID().uuidString
        timetableEntity.setValue(id,  forKey: "id")
        timetableEntity.setValue(name, forKey: "name")
        timetableEntity.setValue(semester, forKey: "semester")
        UserDefaults.standard.set(id, forKey: "id")
        do {
            try context.save()
        } catch {
            print("@Log - \(error.localizedDescription)")
        }
        
    }
    
    /// func saveFirebaseCourse: 파이어베이스에 저장된 데이터를 코어데이터에 저장합니다.
    /// - Parameter course : [[String: Any]]
    /// NSBatchInsertRequest Objects
    func saveFirebaseCourse(course: [[String: Any]]) throws {
        //    course: [[String: Any]]
        guard let context = context else {
            throw CoreDataError.contextError
        }
        guard let entity = NSEntityDescription.entity(forEntityName: "FirebaseCourse", in: context) else {
            throw CoreDataError.entityError
        }

        let batchInsertRequest = NSBatchInsertRequest(entity: entity, objects: course)
        if let fetchResult = try? context.execute(batchInsertRequest),
           let batchInsertResult = fetchResult as? NSBatchInsertResult,
           let success = batchInsertResult.result as? Bool, success {
            print("저장 성공!")
            return
        }
        print("Batch Insert Error")
        throw CoreDataError.batchInsertError
    }
    
    /// func saveTimetableCourse: 선택된 시간표에 강의를 저장합니다.
    /// - Parameter id : timetable id
    /// - Parameter course : 추가할 강의
    func saveCourse(id: String, course: TimetableCourse) throws {
        guard let context = context else {
            throw CoreDataError.contextError
        }
        
        let fetchRequest = Timetable.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id)
        
        do {
            guard let timetable = try context.fetch(fetchRequest).first else {
                throw CoreDataError.fetchError
            }
            
            let courseEntity = Course(context: context)
            courseEntity.courseId = course.courseId
            courseEntity.courseName = course.courseName
            courseEntity.roomName = course.roomName
            courseEntity.courseDay = Int16(course.courseDay)
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

}
