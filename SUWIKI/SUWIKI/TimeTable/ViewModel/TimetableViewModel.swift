//
//  TimeTableViewModel.swift
//  SUWIKI
//
//  Created by 한지석 on 2023/06/13.
//

import Foundation

import Elliotable

final class TimetableViewModel {
    
    let coreDataManager = CoreDataManager.shared
    
    func getTimeTableCourse() -> [TimetableCourse] {
        let timetableCourseData = coreDataManager.getTimetableCourseFromCoreData()
        var timetableCourse: [TimetableCourse] = []
        for i in 0..<timetableCourseData.count {
            let course = TimetableCourse(courseId: UUID().uuidString,
                                         courseName: timetableCourseData[i].courseName ?? "",
                                         roomName: timetableCourseData[i].roomName ?? "",
                                         professor: timetableCourseData[i].professor ?? "",
                                         courseDay: 1,
                                         startTime: timetableCourseData[i].startTime ?? "",
                                         endTime: timetableCourseData[i].endTime ?? "")
            timetableCourse.append(course)
        }
        return timetableCourse
    }
    
    func getElliotEvent() -> [ElliottEvent] {
        var elliotEvent: [ElliottEvent] = []
        let timetableCourse = getTimeTableCourse()
        for i in 0..<timetableCourse.count {
            let course = ElliottEvent(courseId: timetableCourse[i].courseId,
                                      courseName: timetableCourse[i].courseName,
                                      roomName: timetableCourse[i].roomName,
                                      professor: timetableCourse[i].professor,
                                      courseDay: ElliotDay(rawValue: timetableCourse[i].courseDay)!,
                                      startTime: timetableCourse[i].startTime,
                                      endTime: timetableCourse[i].endTime,
                                      backgroundColor: .black)
            elliotEvent.append(course)
        }
        return elliotEvent
    }
    
}
