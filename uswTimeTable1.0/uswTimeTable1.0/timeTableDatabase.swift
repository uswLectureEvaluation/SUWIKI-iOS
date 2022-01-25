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

class testCourseData: Object{
   
    @objc dynamic var courseId: String = ""
    @objc dynamic var courseName: String = ""
    @objc dynamic var roomName: String = ""
    @objc dynamic var professor: String = ""
    @objc dynamic var classification: String = ""
    @objc dynamic var courseDay: String = ""
    @objc dynamic var startTime: String = ""
    @objc dynamic var endTime: String = ""
    @objc dynamic var major: String = ""
    @objc dynamic var credit: Int = 0
    @objc dynamic var num: Int = 0
    @objc dynamic var classNum: String = ""
    @objc dynamic var time: String = ""
    
    convenience init(courseName: String, roomName: String, professor: String) {
        self.init()
        self.courseName = courseName
        self.roomName = roomName
        self.professor = professor
    }


}

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
    @objc dynamic var year: String = ""
    @objc dynamic var semester: String = ""
    @objc dynamic var timetableName: String = ""
}

class timeTest: Object{
    @objc dynamic var roomName: String = ""
    @objc dynamic var professor: String = ""
    @objc dynamic var courseName: String = ""
}
