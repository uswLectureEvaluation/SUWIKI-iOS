//
//  DefaultTimetableStorage.swift
//  SUWIKI
//
//  Created by 한지석 on 4/13/24.
//

import Foundation
import CoreData

final class DefaultTimetableStorage: TimetableStorage {

    let coreDataManager = CoreDataManager.shared

    func saveTimetable(
        name: String,
        semester: String
    ) throws {
        guard let entity = NSEntityDescription.entity(forEntityName: "Timetable", in: coreDataManager.context) else { return }
        let timetableEntity = NSManagedObject(entity: entity, insertInto: coreDataManager.context)
        let id = UUID().uuidString
        timetableEntity.setValue(id, forKey: "id")
        timetableEntity.setValue(name, forKey: "name")
        timetableEntity.setValue(semester, forKey: "semester")
        do {
            try coreDataManager.context.save()
            UserDefaults.shared.set(id, forKey: "id")
        } catch {
            throw CoreDataError.saveError
        }
    }

    /// func fetchTimetable: Core Data에 저장된 Timetable을 fetch합니다.
    func fetchTimetable(id: String) throws -> Timetable? {
        var timetable: [Timetable] = []
        do {
            let fetchRequest = Timetable.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "id == %@", id)
            timetable = try coreDataManager.context.fetch(fetchRequest)
        } catch {
            throw CoreDataError.fetchError
        }
        return timetable.first
    }
    
    /// func fetchCourses: Core Data에 저장된 Course를 fetch합니다.
    func fetchCourses(id: String) throws -> [Course]? {
        var courses: [Course] = []
        do {
            let fetchRequest = Timetable.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "id == %@", id)
            let timetable = try coreDataManager.context.fetch(fetchRequest)
            if let timetableCourses = timetable.first?.courses as? Set<Course> {
                courses = Array(timetableCourses)
            }
        } catch {
            throw CoreDataError.fetchError
        }
        return courses
    }

}
