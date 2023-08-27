//
//  CoreDataManager+Create.swift
//  SUWIKI
//
//  Created by 한지석 on 2023/07/31.
//

import Foundation
import CoreData

extension CoreDataManager {
    
    func saveTimetable(name: String, semester: String) {
        guard let context = context else { return }
        guard let entity = NSEntityDescription.entity(forEntityName: "Timetable", in: context) else { return }
        let timetableEntity = NSManagedObject(entity: entity, insertInto: context)
        timetableEntity.setValue(UUID().uuidString, forKey: "id")
        timetableEntity.setValue(name, forKey: "name")
        timetableEntity.setValue(semester, forKey: "semester")
        do {
            try context.save()
        } catch {
            print("@Log - \(error.localizedDescription)")
        }
        
    }
    
    // MARK: - [Create] 코어데이터에 데이터 생성하기
    func saveFirebaseCourse(course: [FetchCourse]) throws {
        guard let context = context else {
            throw CoreDataError.contextError
        }
        guard let entity = NSEntityDescription.entity(forEntityName: "FirebaseCourse", in: context) else {
            throw CoreDataError.entityError
        }
        
        let batchInsertRequest = createBatchInsertRequest(entity: entity, course: course)
        if let fetchResult = try? context.execute(batchInsertRequest),
           let batchInsertResult = fetchResult as? NSBatchInsertResult,
           let success = batchInsertResult.result as? Bool, success {
            return
        }
        throw CoreDataError.batchInsertError
    }
    
    func createBatchInsertRequest(entity: NSEntityDescription, course: [FetchCourse]) -> NSBatchInsertRequest {
        var dictionaries: [[String: Any]] = []
         
        for fetchCourse in course {
            var courseDictionary: [String: Any] = [:]
            courseDictionary["classNum"] = fetchCourse.classNum
            courseDictionary["classification"] = fetchCourse.classification
            courseDictionary["courseDay"] = fetchCourse.courseDay
            courseDictionary["courseName"] = fetchCourse.courseName
            courseDictionary["credit"] = fetchCourse.credit
            courseDictionary["startTime"] = fetchCourse.startTime
            courseDictionary["endTime"] = fetchCourse.endTime
            courseDictionary["major"] = fetchCourse.major
            courseDictionary["num"] = fetchCourse.num
            courseDictionary["professor"] = fetchCourse.professor
            courseDictionary["roomName"] = fetchCourse.roomName
            dictionaries.append(courseDictionary)
        }
        
        let batchInsertRequest = NSBatchInsertRequest(entity: entity, objects: dictionaries)
        return batchInsertRequest
    }
    
//    private func importQuakes(from propertiesList: [QuakeProperties]) async throws {
//        guard !propertiesList.isEmpty else { return }
//
//        let taskContext = newTaskContext()
//        // Add name and author to identify source of persistent history changes.
//        taskContext.name = "importContext"
//        taskContext.transactionAuthor = "importQuakes"
//
//        /// - Tag: performAndWait
//        try await taskContext.perform {
//            // Execute the batch insert.
//            /// - Tag: batchInsertRequest
//            let batchInsertRequest = self.newBatchInsertRequest(with: propertiesList)
//            if let fetchResult = try? taskContext.execute(batchInsertRequest),
//               let batchInsertResult = fetchResult as? NSBatchInsertResult,
//               let success = batchInsertResult.result as? Bool, success {
//                return
//            }
//            self.logger.debug("Failed to execute batch insert request.")
//            throw QuakeError.batchInsertError
//        }
//
//        logger.debug("Successfully inserted data.")
//    }
//
//    private func newBatchInsertRequest(with propertyList: [QuakeProperties]) -> NSBatchInsertRequest {
//        var index = 0
//        let total = propertyList.count
//
//        // Provide one dictionary at a time when the closure is called.
//        let batchInsertRequest = NSBatchInsertRequest(entity: Quake.entity(), dictionaryHandler: { dictionary in
//            guard index < total else { return true }
//            dictionary.addEntries(from: propertyList[index].dictionaryValue)
//            index += 1
//            return false
//        })
//        return batchInsertRequest
//    }
    
//    for i in 0..<course.count {
//        // 외부에서 객체를 초기화할 경우 동일한 객체를 가리키기 때문에 하나만 저장이 됨.
//        let courseEntity = NSManagedObject(entity: entity, insertInto: context)
//        courseEntity.setValue(course[i].classNum, forKey: "classNum")
//        courseEntity.setValue(course[i].classification, forKey: "classification")
//        courseEntity.setValue(course[i].courseDay, forKey: "courseDay")
//        courseEntity.setValue(course[i].courseName, forKey: "courseName")
//        courseEntity.setValue(course[i].credit, forKey: "credit")
//        courseEntity.setValue(course[i].startTime, forKey: "startTime")
//        courseEntity.setValue(course[i].endTime, forKey: "endTime")
//        courseEntity.setValue(course[i].major, forKey: "major")
//        courseEntity.setValue(course[i].num, forKey: "year")
//        courseEntity.setValue(course[i].professor, forKey: "professor")
//        courseEntity.setValue(course[i].roomName, forKey: "roomName")
//        try? context?.save()
//    }
    //                    print("@Log - \(result[0].courses?.count)")
    
    
    
//        guard let entity = NSEntityDescription.entity(forEntityName: "Course", in: context) else {
//            return
//        }

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
    
//    let courseEntity = NSManagedObject(entity: entity, insertInto: context) as? Course {
//        courseEntity?.courseId = course.courseId
//        courseEntity.courseName = course.courseName
//    }
    
    
}

//// MARK: - [Create] 코어데이터에 데이터 생성하기
//func saveToDoData(toDoText: String?, colorInt: Int64, completion: @escaping () -> Void) {
//    // 임시저장소 있는지 확인
//    if let context = context {
//        // 임시저장소에 있는 데이터를 그려줄 형태 파악하기
//        if let entity = NSEntityDescription.entity(forEntityName: self.modelName, in: context) {
//
//            // 임시저장소에 올라가게 할 객체만들기 (NSManagedObject ===> ToDoData)
//            if let toDoData = NSManagedObject(entity: entity, insertInto: context) as? ToDoData {
//
//                // MARK: - ToDoData에 실제 데이터 할당 ⭐️
//                toDoData.memoText = toDoText
//                toDoData.date = Date()   // 날짜는 저장하는 순간의 날짜로 생성
//                toDoData.color = colorInt
//
//                //appDelegate?.saveContext() // 앱델리게이트의 메서드로 해도됨
//                if context.hasChanges {
//                    do {
//                        try context.save()
//                        completion()
//                    } catch {
//                        print(error)
//                        completion()
//                    }
//                }
//            }
//        }
//    }
//    completion()
//}


