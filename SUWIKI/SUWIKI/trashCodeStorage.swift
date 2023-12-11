////
////  trashCodeStorage.swift
////  SUWIKI
////
////  Created by 한지석 on 2023/08/09.
////
//
//import Foundation
//
///// func isCommonCourseDuplicated: 0번 케이스. 일반적인 시간표의 경우에서 시간표가 중복되는지 검증
///// parameter: existingCourse, course
///// return bool(isDuplicated)
//func isCommonCourseDuplicated(existingCourse: [Course], course: TimetableCourse) -> Bool {
//    var isDuplicated = false
//    for i in 0..<existingCourse.count {
//        if isCourseDuplicated(existingCourse: existingCourse[i], newCourse: course) {
//            isDuplicated = true
//            break
//        }
//    }
//    return isDuplicated
//}
//
//
///// func isDifferentTimeCourseDuplicated: 1번 케이스, 시간이 다른 경우에서 시간표가 중복되는지 검증
///// parameter: TimetableCourse
///// return: Bool(isDuplicated)
//func iㅌsDifferentTimeCourseDuplicated(existingCourse: [Course], course: TimetableCourse) -> Bool {
//    var isDuplicated = false
//    let differentTimeCourse = differentTime(course: course)
//    for i in 0..<existingCourse.count {
//        for j in 0..<differentTimeCourse.count {
//            if isCourseDuplicated(existingCourse: existingCourse[i], newCourse: differentTimeCourse[j]) {
//                isDuplicated = true
//                break
//            }
//        }
//    }
//    return isDuplicated
//}
//
//// 자연대112(월1,2 화3,4 수5,6) (월1 수5,6)
//// 공백으로 카운트
///// 0번째 이후의 로직은 같음
//
//func differentTime(course: TimetableCourse) -> [TimetableCourse] {
//    var timeTableCourse: [TimetableCourse] = []
//    let components = course.roomName.split(separator: " ")
//
//    // index == 0
//    let firstIndex = components[0].firstIndex(of: "(")
//    let firstDayIndex = components[0].index(after: firstIndex!)
//    let firstDay = String(components[0][firstDayIndex])
//    let firstTime = components[0].split(separator: firstDay)[1].split(separator: ",")
//    let firstStartTime = String(firstTime[0])
//    let firstEndTime = String(firstTime[firstTime.count - 1])
//
//    print("day, start, end - \(firstDay), \(firstStartTime), \(firstEndTime)")
//    timeTableCourse.append(TimetableCourse(courseId: UUID().uuidString,
//                                           courseName: course.courseName,
//                                           roomName: course.roomName,
//                                           professor: course.professor,
//                                           courseDay: dayToInt(courseDay: firstDay),
//                                           startTime: startTimeToString(start: firstStartTime),
//                                           endTime: endTimeToString(end: firstEndTime)))
//    // if count == 3, index == 1
//    if components.count == 3 {
//        var secondDay = ""
//        if let day = components[1].first {
//            secondDay = String(day)
//        }
//        let secondTime = components[1].dropFirst().split(separator: ",")
//        let secondStartTime = String(secondTime[0])
//        let secondEndTime = String(secondTime[secondTime.count - 1])
//        timeTableCourse.append(TimetableCourse(courseId: UUID().uuidString,
//                                               courseName: course.courseName,
//                                               roomName: course.roomName,
//                                               professor: course.professor,
//                                               courseDay: dayToInt(courseDay: secondDay),
//                                               startTime: startTimeToString(start: secondStartTime),
//                                               endTime: endTimeToString(end: secondEndTime)))
//    }
//
//    // lastIndex
//    var lastDay = ""
//    if let day = components[components.count - 1].first {
//        lastDay = String(day)
//    }
//    // 목7,8)
//    let lastTime = components[components.count - 1].dropFirst().split(separator: ",")
//    // "7","8)"
//    print(lastTime)
//    let lastStartTime = String(lastTime[0])
//    let lastEndTime = String(lastTime[lastTime.count - 1].dropLast())
//
//    print("day, start, end - \(lastDay), \(lastStartTime), \(lastEndTime)")
//    timeTableCourse.append(TimetableCourse(courseId: UUID().uuidString,
//                                           courseName: course.courseName,
//                                           roomName: course.roomName,
//                                           professor: course.professor,
//                                           courseDay: dayToInt(courseDay: lastDay),
//                                           startTime: startTimeToString(start: lastStartTime),
//                                           endTime: endTimeToString(end: lastEndTime)))
//    print(timeTableCourse)
//    return timeTableCourse
//}
//
///// func isDifferentPlaceCourseDuplicated: 2번 케이스. 장소가 다른 경우에서 시간표가 중복되는지 검증
///// parameter: TimetableCourse
///// return: Bool(isDuplicated)
//func isDifferentPlaceCourseDuplicated(existingCourse: [Course], course: TimetableCourse) -> Bool {
//    var isDuplicated = false
//    return isDuplicated
//}
//
///// ),을 기준으로 쪼개야 함
//
//func differentPlace(course: TimetableCourse) -> [TimetableCourse] {
//    var timeTableCourse: [TimetableCourse] = []
//
//    let components = course.roomName.split(separator: "),")
//
//    for i in 0..<components.count {
//        let firstIndex = components[i].firstIndex(of: "(")
//        let dayIndex = components[i].index(after: firstIndex!)
//        let startIndex = components[i].index(after: dayIndex)
//
//        let dayString = String(components[i][dayIndex])
//        let start = String(components[i][startIndex])
//        var end = ""
//
//        if i == 0 { // lastString
//            if let lastString = components[i].last {
//                end = String(lastString)
//            }
//        } else { // lastString - 1
//            let endTimedropLastString = components[i].dropLast()
//            if let lastString = endTimedropLastString.last {
//                end = String(lastString)
//            }
//        }
//        let courseDay = dayToInt(courseDay: dayString)
//        let startTime = startTimeToString(start: start)
//        let endTime = endTimeToString(end: end)
//        timeTableCourse.append(TimetableCourse(courseId: UUID().uuidString,
//                                               courseName: course.courseName,
//                                               roomName: course.roomName,
//                                               professor: course.professor,
//                                               courseDay: courseDay,
//                                               startTime: startTime,
//                                               endTime: endTime))
//    }
//
//    return timeTableCourse
//}
//
//func getTimetableCourse() {
//
//}
//
///// func isCourseDuplicated: 강의 중복 확인, String -> Int로 형변환하여 대소비교
///// 만약 같은 요일에 강의가 존재하고, 11:30 - 13:30에 강의가 존재
///// 1. startTime
///// - 11:30 ~ 13:20 사이에 존재한다면 중복
///// -
///// 2. endTime
///// - 11:30 ~ 13:20 사이에 존재한다면 중복
/////
///// true : 중복 / false : 노중복
//func isCourseDuplicated(existingCourse: Course, newCourse: TimetableCourse) -> Bool{
//    /// 데이터베이스에 저장된 시작 / 종료시간을 Int형으로 변환하여 중복확인을 위한 변수.
//    /// - startTime,endTimeStr = "9:30" -> startTime, endTime = 930
//    let existingCourseStartTimeStr = existingCourse.startTime?.filter { $0 != ":" }
//    let existingCourseEndTimeStr = existingCourse.endTime?.filter { $0 != ":" }
//    let newCourseStartTimeStr = newCourse.startTime.filter { $0 != ":" }
//    let newCourseEndTimeStr = newCourse.endTime.filter { $0 != ":" }
//    guard let existingCourseStartTime = Int(existingCourseStartTimeStr ?? "100"),
//          let existingCourseEndTime = Int(existingCourseEndTimeStr ?? "100"),
//          let newCourseStartTime = Int(newCourseStartTimeStr),
//          let newCourseEndTime = Int(newCourseEndTimeStr)
//    else { return true }
//    return isTimeDuplicated(existingStart: existingCourseStartTime,
//                            existingEnd: existingCourseEndTime,
//                            newStart: newCourseStartTime,
//                            newEnd: newCourseEndTime)
//}
//
///// func startTime & endTime To Int
///// [930, 1030, 1130, 1230, 1330, 1430, 1530, 1630, 1730, 1830, 1930, 2030, 2130, 2230,  2330]
///// [1020, 1120, 1220, 1320, 1420, 1520, 1620, 1720, 1820, 1920, 2020, 2120, 2220, 2320, 2420]
//func startTimeToInt(start: String) -> Int {
//    let startTimeIntArray = [930, 1030, 1130, 1230, 1330, 1430, 1530, 1630, 1730, 1830, 1930, 2030, 2130, 2230, 2330]
//    if let index = Int(start) {
//        return startTimeIntArray[index]
//    }
//    // 그럴일이 없지만 숫자가 아닌게 넘어온다면 어떻게 처리해야할까
//    return startTimeIntArray[14]
//}
//
//func endTimeToInt(end: String) -> Int {
//    let endTimeIntArray = [1020, 1120, 1220, 1320, 1420, 1520, 1620, 1720, 1820, 1920, 2020, 2120, 2220, 2320, 2420]
//    if let index = Int(end) {
//        return endTimeIntArray[index]
//    }
//    return endTimeIntArray[14]
//}
//
///// func timeToString
///// 930 -> "9:30"
//func startTimeToString(start: String) -> String {
//    let startTimeStringArray = ["9:30", "10:30", "11:30", "12:30", "13:30", "14:30", "15:30", "16:30", "17:30", "18:30", "19:30", "20:30", "21:30", "22:30", "23:30"]
//    if let index = Int(start) {
//        return startTimeStringArray[index]
//    }
//    return startTimeStringArray[14]
//}
//
//func endTimeToString(end: String) -> String {
//    let endTimeStringArray = ["10:20", "11:20", "12:20", "13:20", "14:20", "15:20", "16:20", "17:20", "18:20", "19:20", "20:20", "21:20", "22:20", "23:20", "24:20"]
//    if let index = Int(end) {
//        return endTimeStringArray[index]
//    }
//    return endTimeStringArray[14]
//}
//
///// func dayToInt - 월 -> 1 화 -> 2 수 -> 목
//func dayToInt(courseDay: String) -> Int {
//    var dayToString = 6
//    switch courseDay {
//    case "월":
//        dayToString = 1
//    case "화":
//        dayToString = 2
//    case "수":
//        dayToString = 3
//    case "목":
//        dayToString = 4
//    case "금":
//        dayToString = 5
//    default:
//        break
//    }
//    return dayToString
//}
//
////        if existingStart < newEnd {||
////            (existingStart == newStart && existingEnd == newEnd) ||
////            existingEnd > newStart ||
////            (existingStart >= newStart && existingEnd <= newEnd) ||
////            (existingStart <= newStart && existingEnd >= newEnd) {
////            return false
////        }
//func isTimeDuplicated(existingStart: Int, existingEnd: Int, newStart: Int, newEnd: Int) -> Bool {
//    //        print("time - \(existingStart) - \(existingEnd), \(newStart) - \(newEnd)")
//    if existingStart > newEnd || existingEnd < newStart {
//        return false
//    }
//    return true
//}

//func tempStringToDate() {
//    let timetableCourseData = coreDataManager.fetchCourse()
//    
//    let courseDataStartTime = timetableCourseData[0].startTime?.filter { $0 != ":" }
//    let courseDataEndTime = timetableCourseData[0].endTime?.filter { $0 != ":" }
//    guard let startTime = Int(courseDataStartTime ?? "100") else { return }
//    guard let endTime = Int(courseDataEndTime ?? "100") else { return }
//    print(startTime)
//    //            .map { Int(String($0)) }
//}
//
//func tempCheckCourse() {
//    let temp = coreDataManager.fetchCourse()
//    print(temp.count)
//    for i in 0..<temp.count {
//        print("\(i)번째 데이터")
//        print(temp[i].courseName)
//        print("startTime - \(temp[i].startTime)")
//        print("endTime - \(temp[i].endTime)")
//    }
//}
