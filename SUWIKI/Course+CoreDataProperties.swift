//
//  Course+CoreDataProperties.swift
//  
//
//  Created by 한지석 on 2023/06/19.
//
//

import Foundation
import CoreData


extension Course {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Course> {
        return NSFetchRequest<Course>(entityName: "Course")
    }

    @NSManaged public var classification: String?
    @NSManaged public var classNum: Int16
    @NSManaged public var courseDay: String?
    @NSManaged public var courseName: String?
    @NSManaged public var credit: Int16
    @NSManaged public var endTime: String?
    @NSManaged public var major: String?
    @NSManaged public var num: Int16
    @NSManaged public var professor: String?
    @NSManaged public var roomName: String?
    @NSManaged public var startTime: String?

}
