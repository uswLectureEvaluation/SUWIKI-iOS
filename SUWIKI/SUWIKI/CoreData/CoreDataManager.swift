//
//  CoreDataManager.swift
//  SUWIKI
//
//  Created by 한지석 on 2023/06/13.
//

import UIKit
import CoreData

//MARK: - To do 관리하는 매니저 (코어데이터 관리)

final class CoreDataManager {
    
    // 싱글톤으로 만들기
    static let shared = CoreDataManager()
    private init() {}
    
    // 앱 델리게이트
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    // 임시저장소
    lazy var context = appDelegate?.persistentContainer.viewContext
    
    // 엔터티 이름 (코어데이터에 저장된 객체)
    let modelName: String = "Course"
    
    // MARK: - [Read] 코어데이터에 저장된 데이터 모두 읽어오기
    func getFirebaseCourseFromCoreData() -> [FirebaseCourseData] {
        var course: [FirebaseCourseData] = []
        if let context = context {
            do {
                course = try context.fetch(FirebaseCourseData.fetchRequest())
            } catch {
                print(error.localizedDescription)
            }
        }
        return course
    }
    
    func getTimetableCourseFromCoreData() -> [TimetableCourseData] {
        var course: [TimetableCourseData] = []
        if let context = context {
            do {
                course = try context.fetch(TimetableCourseData.fetchRequest())
            } catch {
                print(error.localizedDescription)
            }
        }
        return course
    }
    
    // MARK: - [Create] 코어데이터에 데이터 생성하기
    func saveFirebaseCourse(course: [FirebaseCourse]) {
        if context != nil {
            guard let entity = NSEntityDescription.entity(forEntityName: "FirebaseCourseData", in: context!) else {
                return
            }
            for i in 0..<course.count {
                // 외부에서 객체를 초기화할 경우 동일한 객체를 가리키기 때문에 하나만 저장이 됨.
                let courseEntity = NSManagedObject(entity: entity, insertInto: context)
                courseEntity.setValue(course[i].classNum, forKey: "classNum")
                courseEntity.setValue(course[i].classification, forKey: "classification")
                courseEntity.setValue(course[i].courseDay, forKey: "courseDay")
                courseEntity.setValue(course[i].courseName, forKey: "courseName")
                courseEntity.setValue(course[i].credit, forKey: "credit")
                courseEntity.setValue(course[i].startTime, forKey: "startTime")
                courseEntity.setValue(course[i].endTime, forKey: "endTime")
                courseEntity.setValue(course[i].major, forKey: "major")
                courseEntity.setValue(course[i].num, forKey: "num")
                courseEntity.setValue(course[i].professor, forKey: "professor")
                courseEntity.setValue(course[i].roomName, forKey: "roomName")
                try? context?.save()
            }
        }
    }
    
    func saveTimetableCourse(course: TimetableCourse) {
        if context != nil {
            guard let entity = NSEntityDescription.entity(forEntityName: "TimetableCourseData", in: context!) else {
                return
            }
            let courseEntity = NSManagedObject(entity: entity, insertInto: context)
            courseEntity.setValue(course.courseId, forKey: "courseId")
            courseEntity.setValue(course.courseName, forKey: "courseName")
            courseEntity.setValue(course.roomName, forKey: "roomName")
            courseEntity.setValue(course.professor, forKey: "professor")
            courseEntity.setValue(course.courseDay, forKey: "courseDay")
            courseEntity.setValue(course.startTime, forKey: "startTime")
            courseEntity.setValue(course.endTime, forKey: "endTime")
            try? context?.save()
        }
    }
    
//    func save
//    func saveToDoData(toDoText: String?, colorInt: Int64, completion: @escaping () -> Void) {
//        // 임시저장소 있는지 확인
//        if let context = context {
//            // 임시저장소에 있는 데이터를 그려줄 형태 파악하기
//            if let entity = NSEntityDescription.entity(forEntityName: self.modelName, in: context) {
//
//                // 임시저장소에 올라가게 할 객체만들기 (NSManagedObject ===> ToDoData)
//                if let toDoData = NSManagedObject(entity: entity, insertInto: context) as? ToDoData {
//
//                    // MARK: - ToDoData에 실제 데이터 할당 ⭐️
//                    toDoData.memoText = toDoText
//                    toDoData.date = Date()   // 날짜는 저장하는 순간의 날짜로 생성
//                    toDoData.color = colorInt
//
//                    //appDelegate?.saveContext() // 앱델리게이트의 메서드로 해도됨
//                    if context.hasChanges {
//                        do {
//                            try context.save()
//                            completion()
//                        } catch {
//                            print(error)
//                            completion()
//                        }
//                    }
//                }
//            }
//        }
//        completion()
//    }
//
//    // MARK: - [Delete] 코어데이터에서 데이터 삭제하기 (일치하는 데이터 찾아서 ===> 삭제)
//    func deleteToDo(data: ToDoData, completion: @escaping () -> Void) {
//        // 날짜 옵셔널 바인딩
//        guard let date = data.date else {
//            completion()
//            return
//        }
//
//        // 임시저장소 있는지 확인
//        if let context = context {
//            // 요청서
//            let request = NSFetchRequest<NSManagedObject>(entityName: self.modelName)
//            // 단서 / 찾기 위한 조건 설정
//            request.predicate = NSPredicate(format: "date = %@", date as CVarArg)
//
//            do {
//                // 요청서를 통해서 데이터 가져오기 (조건에 일치하는 데이터 찾기) (fetch메서드)
//                if let fetchedToDoList = try context.fetch(request) as? [ToDoData] {
//
//                    // 임시저장소에서 (요청서를 통해서) 데이터 삭제하기 (delete메서드)
//                    if let targetToDo = fetchedToDoList.first {
//                        context.delete(targetToDo)
//
//                        //appDelegate?.saveContext() // 앱델리게이트의 메서드로 해도됨
//                        if context.hasChanges {
//                            do {
//                                try context.save()
//                                completion()
//                            } catch {
//                                print(error)
//                                completion()
//                            }
//                        }
//                    }
//                }
//                completion()
//            } catch {
//                print("지우는 것 실패")
//                completion()
//            }
//        }
//    }
//
//    // MARK: - [Update] 코어데이터에서 데이터 수정하기 (일치하는 데이터 찾아서 ===> 수정)
//    func updateToDo(newToDoData: ToDoData, completion: @escaping () -> Void) {
//        // 날짜 옵셔널 바인딩
//        guard let date = newToDoData.date else {
//            completion()
//            return
//        }
//
//        // 임시저장소 있는지 확인
//        if let context = context {
//            // 요청서
//            let request = NSFetchRequest<NSManagedObject>(entityName: self.modelName)
//            // 단서 / 찾기 위한 조건 설정
//            request.predicate = NSPredicate(format: "date = %@", date as CVarArg)
//
//            do {
//                // 요청서를 통해서 데이터 가져오기
//                if let fetchedToDoList = try context.fetch(request) as? [ToDoData] {
//                    // 배열의 첫번째
//                    if var targetToDo = fetchedToDoList.first {
//
//                        // MARK: - ToDoData에 실제 데이터 재할당(바꾸기) ⭐️
//                        targetToDo = newToDoData
//
//                        //appDelegate?.saveContext() // 앱델리게이트의 메서드로 해도됨
//                        if context.hasChanges {
//                            do {
//                                try context.save()
//                                completion()
//                            } catch {
//                                print(error)
//                                completion()
//                            }
//                        }
//                    }
//                }
//                completion()
//            } catch {
//                print("지우는 것 실패")
//                completion()
//            }
//        }
//    }

}

