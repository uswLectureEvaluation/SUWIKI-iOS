//
//  Course+CoreDataProperties.swift
//  
//
//  Created by 한지석 on 1/22/24.
//
//

import Foundation
import CoreData


extension Course {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Course> {
        return NSFetchRequest<Course>(entityName: "Course")
    }

    @NSManaged public var courseDay: Int16
    @NSManaged public var courseId: String?
    @NSManaged public var courseName: String?
    @NSManaged public var endTime: String?
    @NSManaged public var professor: String?
    @NSManaged public var roomName: String?
    @NSManaged public var startTime: String?
    @NSManaged public var timetableColor: Int16
    @NSManaged public var ownerTimetable: Timetable?

}
