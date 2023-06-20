//
//  TimetableCourseData+CoreDataProperties.swift
//  
//
//  Created by 한지석 on 2023/06/20.
//
//

import Foundation
import CoreData


extension TimetableCourseData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TimetableCourseData> {
        return NSFetchRequest<TimetableCourseData>(entityName: "TimetableCourseData")
    }

    @NSManaged public var courseId: Int64
    @NSManaged public var courseName: String?
    @NSManaged public var roomName: String?
    @NSManaged public var professor: String?
    @NSManaged public var courseDay: Int16
    @NSManaged public var startTime: String?
    @NSManaged public var endTime: String?

}
