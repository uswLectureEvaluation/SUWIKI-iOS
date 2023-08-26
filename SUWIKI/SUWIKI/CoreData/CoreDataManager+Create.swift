//
//  CoreDataManager+Create.swift
//  SUWIKI
//
//  Created by 한지석 on 2023/07/31.
//

import Foundation
import CoreData

extension CoreDataManager {
    // MARK: - [Create] 코어데이터에 데이터 생성하기
    func saveFirebaseCourse(course: [FetchCourse]) {
        if context != nil {
            guard let entity = NSEntityDescription.entity(forEntityName: "FirebaseCourse", in: context!) else {
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
                courseEntity.setValue(course[i].num, forKey: "year")
                courseEntity.setValue(course[i].professor, forKey: "professor")
                courseEntity.setValue(course[i].roomName, forKey: "roomName")
                try? context?.save()
            }
        }
    }
    
    func saveTimetableCourse(course: TimetableCourse) {
        print("@Log saveTimetableCourse")
        if context != nil {
            guard let entity = NSEntityDescription.entity(forEntityName: "Course", in: context!) else {
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
            courseEntity.setValue(course.timetableColor, forKey: "timetableColor")
            try? context?.save()
        }
    }
}
