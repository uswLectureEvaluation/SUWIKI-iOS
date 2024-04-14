//
//  CoreDataManager.swift
//  SUWIKI
//
//  Created by 한지석 on 2023/06/13.
//

import UIKit
import CoreData

enum CoreDataError: Error {
    case batchInsertError
    case entityError
    case contextError
    case saveError
    case fetchError
    case deleteError
}

final class CoreDataManager {

    // 싱글톤으로 만들기
    static let shared = CoreDataManager()
    private init() {}

    private static let appGroup = "group.sozohoy.suwiki"

    let container: NSPersistentContainer  = {
        guard let url = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: appGroup) else {
            fatalError("Shared file container could not be created.")
        }
        let storeURL = url.appending(path: "SuwikiTimetable.sqlite")
        let storeDescription = NSPersistentStoreDescription(url: storeURL)
        let container = NSPersistentContainer(name: "SuwikiTimetable")
        container.persistentStoreDescriptions = [storeDescription]
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
            print("Core Data store URL: \(storeDescription.url!)")
        })
        return container
    }()

    // 임시저장소
    lazy var context = container.viewContext

    func checkMainThread() {
        if Thread.isMainThread {
            print("Main Thread")
        } else {
            print("Not Main Thread - \(Thread.current)")
        }
    }

    func handleCoreDataError(_ error: Error) {
        switch error {
        case CoreDataError.batchInsertError:
            print("@Log - Core Data BatchInsert Error")
        case CoreDataError.entityError:
            print("@Log - Core Data Entity Error")
        case CoreDataError.contextError:
            print("@Log - Core Data Context Error")
        case CoreDataError.fetchError:
            print("@Log - Core Data Fetch Error")
        case CoreDataError.saveError:
            print("@Log - Core Data Save Error")
        case CoreDataError.deleteError:
            print("@Log - Core Data Delete Error")
        default:
            print("@Log - Other Error: \(error)")
        }
    }

    /// func fetchCourses: Core Data에 저장된 Course를 fetch합니다.
    func fetchCourses(id: String) throws -> [Course]? {
        var courses: [Course] = []
        do {
            let fetchRequest = Timetable.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "id == %@", id)
            let timetable = try context.fetch(fetchRequest)
            if let timetableCourses = timetable.first?.courses as? Set<Course> {
                courses = Array(timetableCourses)
            }
        } catch {
            throw CoreDataError.fetchError
        }
        return courses
    }

    /// func fetchMajors: 학과를 받아옵니다.
    /// 중복되는 형태를 없애도록 Set으로 구현했습니다.
    func fetchMajors() throws -> [String] {
        var courses: [FirebaseCourse]
        do {
            let fetchRequest = FirebaseCourse.fetchRequest()
            courses = try context.fetch(fetchRequest)
            let majors = Array(Set(courses.compactMap { $0.major })).sorted { $0 < $1 }
            return majors
        } catch {
            throw CoreDataError.fetchError
        }
    }

    func fetchELearningCourse(
        id: String,
        courseDay: Int = 6
    ) -> [Course] {
        var course: [Course] = []
        do {
            checkMainThread()
            let fetchRequest = Timetable.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "id == %@", id)
            let timetable = try context.fetch(fetchRequest)[0]
            if let timetableCourses = timetable.courses as? Set<Course> {
                let filteredCourses = Array(timetableCourses).filter { $0.courseDay == courseDay }
                course = filteredCourses
            }
        } catch {
            fatalError(CoreDataError.fetchError.localizedDescription)
        }
        return course
    }

    /// func fetchCourseCount: 학과 선택 화면에서, 미리 보여줄 강의의 갯수들을 가져옵니다.
    /// return: 강의 Count(Int)
    func fetchCourseCount(major: String) -> Int {
        var count = 0
        do {
            checkMainThread()
            let fetchRequest = FirebaseCourse.fetchRequest()
            if major != "전체" {
                fetchRequest.predicate = NSPredicate(format: "major == %@", major)
            }
            count = try context.count(for: fetchRequest)
        } catch {
            print("@Log - \(error.localizedDescription)")
        }
        return count
    }

}

