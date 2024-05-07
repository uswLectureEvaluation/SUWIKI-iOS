//
//  Timetable+CoreDataProperties.swift
//  
//
//  Created by 한지석 on 4/15/24.
//
//

import Foundation
import CoreData


extension Timetable {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Timetable> {
        return NSFetchRequest<Timetable>(entityName: "Timetable")
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var semester: String?
    @NSManaged public var courses: NSSet?

}

// MARK: Generated accessors for courses
extension Timetable {

    @objc(addCoursesObject:)
    @NSManaged public func addToCourses(_ value: Course)

    @objc(removeCoursesObject:)
    @NSManaged public func removeFromCourses(_ value: Course)

    @objc(addCourses:)
    @NSManaged public func addToCourses(_ values: NSSet)

    @objc(removeCourses:)
    @NSManaged public func removeFromCourses(_ values: NSSet)

}
