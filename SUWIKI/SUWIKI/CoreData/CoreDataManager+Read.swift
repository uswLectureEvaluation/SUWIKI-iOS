//
//  CoreDataManager+Read.swift
//  SUWIKI
//
//  Created by 한지석 on 2023/07/31.
//

import Foundation
import CoreData

extension CoreDataManager {
    
    /// func fetchTimetableList: Core Data에 저장된 Timetable List를 fetch합니다.
    func fetchTimetableList() -> [Timetable] {
        var timetable: [Timetable] = []
        if let context = context {
            do {
                timetable = try context.fetch(Timetable.fetchRequest())
            } catch {
                print("@Log - \(error.localizedDescription)")
            }
        }
        return timetable
    }
    
    /// func fetchTimetable: Core Data에 저장된 Timetable을 fetch합니다.
    func fetchTimetable(id: String) -> Timetable? {
        var timetable: [Timetable] = []
        print("@Log id - \(id)")
        if let context = context {
            do {
                let fetehRequest = Timetable.fetchRequest()
                fetehRequest.predicate = NSPredicate(format: "id == %@", id)
                timetable = try context.fetch(fetehRequest)
                
            } catch {
                print("@Log - \(error.localizedDescription)")
            }
        }
        for i in 0..<timetable.count {
            print("@Log fetch - \(timetable[i].id) - \(timetable[i].name)")
        }
        
        
        if timetable.count > 0 {
            return timetable[0]
        } else {
            return nil
        }
    }
    
    /// func fetchCourse: Core Data에 저장된 Course를 fetch합니다.
    func fetchCourse(id: String) -> [Course] {
        var course: [Course] = []
        if let context = context {
            do {
                let fetchRequest = Timetable.fetchRequest()
                fetchRequest.predicate = NSPredicate(format: "id == %@", id)
                let timetable = try context.fetch(fetchRequest)
                if let timetableCourses = timetable.first?.courses as? Set<Course> {
                    course = Array(timetableCourses)
                }
            } catch {
                print("@Log - \(error.localizedDescription)")
            }
        }
        return course
    }
    
    /// func fetchFirebaseCourse: 학과 선택 시, 과목을 선택하는 화면에서 firebaseCourse를 내려받습니다.(강의 원본)
    /// - Parameter : major(학과, String)
    /// - return : [FireabaseCourse]
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
