//
//  CoreDataManager+Delete.swift
//  SUWIKI
//
//  Created by 한지석 on 2023/07/31.
//

import Foundation
import CoreData

extension CoreDataManager {
    
    func deleteCourse(id: String, courseId: String) throws {
        guard let context = context else { throw CoreDataError.contextError }
        let fetchRequest = Timetable.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id)
        do {
            let timetable = try context.fetch(fetchRequest)
            guard let courses = timetable[0].courses as? Set<Course>,
                  let removeCourse = courses.first(where: { $0.courseId == courseId})
            else {
                throw CoreDataError.deleteError
            }
            timetable[0].removeFromCourses(removeCourse)
            context.delete(removeCourse)
            try context.save()
        } catch {
            throw CoreDataError.deleteError
        }
    }
    
    func deleteTimetable(id: String) throws {
        guard let context = context else { throw CoreDataError.contextError }
        let fetchRequest = Timetable.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id)
        do {
            let timetable = try context.fetch(fetchRequest)
            context.delete(timetable[0])
            try context.save()
        } catch {
            throw CoreDataError.deleteError
        }
    }
    
}
