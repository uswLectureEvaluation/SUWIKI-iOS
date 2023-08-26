//
//  CoreDataManager+Read.swift
//  SUWIKI
//
//  Created by 한지석 on 2023/07/31.
//

import Foundation
import CoreData

extension CoreDataManager {
    
    /// func fetchCourse: Core Data에 저장된 Course를 fetch합니다.
    func fetchCourse() -> [Course] {
        var course: [Course] = []
        if let context = context {
            do {
                course = try context.fetch(Course.fetchRequest())
            } catch {
                print("@Log - \(error.localizedDescription)")
            }
        }
        return course
    }
    
    /// func fetchFirebaseCourse: 학과 선택 시, 과목을 선택하는 화면에서 firebaseCourse를 내려받습니다.(강의 원본)
    /// return: [FirebaseCourse]
    func fetchFirebaseCourse(major: String) -> [FirebaseCourse] {
        var course: [FirebaseCourse] = []
        if let context = context {
            do {
                let fetchRequest = FirebaseCourse.fetchRequest()
                if major != "전체" {
                    fetchRequest.predicate = NSPredicate(format: "major == %@", major)
                }
                course = try context.fetch(fetchRequest)
            } catch {
                print("@Log getFirebaseCourseFromCoreData - \(error.localizedDescription)")
            }
        }
        let sortedCourse = course.sorted {
            $0.courseName! < $1.courseName!
        }
//        for i in 0..<sortedCourse.count {
//            print(sortedCourse[i].)
//        }
        return sortedCourse
    }
    
    /// func fetchCourseCount: 학과 선택 화면에서, 미리 보여줄 강의의 갯수들을 가져옵니다.
    /// return: 강의 Count(Int)
    func fetchCourseCount(major: String) -> Int {
        var count = 0
        if let context = context {
            do {
                let fetchRequest = FirebaseCourse.fetchRequest()
                if major != "전체" {
                    fetchRequest.predicate = NSPredicate(format: "major == %@", major)
                }
                count = try context.count(for: fetchRequest)
            } catch {
                print("@Log - \(error.localizedDescription)")
            }
        }
        return count
    }
}
