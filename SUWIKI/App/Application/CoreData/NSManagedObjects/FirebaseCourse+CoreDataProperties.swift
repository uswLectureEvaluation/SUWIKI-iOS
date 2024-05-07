//
//  FirebaseCourse+CoreDataProperties.swift
//  
//
//  Created by 한지석 on 4/15/24.
//
//

import Foundation
import CoreData


extension FirebaseCourse {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FirebaseCourse> {
        return NSFetchRequest<FirebaseCourse>(entityName: "FirebaseCourse")
    }

    @NSManaged public var classification: String?
    @NSManaged public var classNum: String?
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
