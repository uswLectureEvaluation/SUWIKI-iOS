//
//  timeTableDatabase.swift
//  uswTimeTable1.0
//
//  Created by 한지석 on 2022/01/06.
//

import Foundation 
import RealmSwift
import Elliotable
import Accessibility

class testCourse: Object{
    
    @objc dynamic var courseId: String = ""
    @objc dynamic var courseName: String = ""
    @objc dynamic var roomName: String = ""
    @objc dynamic var professor: String = ""
    @objc dynamic var startTime: String = ""
    @objc dynamic var endTime: String = ""
    @objc dynamic var courseDay = ElliotDay.monday.rawValue
    
}

class userDB: Object{
    @objc dynamic var year: Int = 0
    @objc dynamic var semester: Int = 0
    @objc dynamic var timetableName: String = ""
    @objc dynamic var timetableJsonData: String = ""
}
