//
//  AddCourseListViewModel.swift
//  SUWIKI
//
//  Created by 한지석 on 2023/06/19.
//

import Foundation
import Combine

class AddCourseListViewModel: ObservableObject {
//    var bag = Set<AnyCancellable>()
    let coreDataManager = CoreDataManager.shared
    @Published var isSelected: Bool = false
    var selectedIndex: Int = -1 {
        didSet {
            isSelected = selectedIndex != -1
        }
    }
    
    private var courseList: [FirebaseCourseData] {
//        print(coreDataManager.getFirebaseTemp())
//        return coreDataManager.getFirebaseCourseFromCoreData()
        return coreDataManager.getFirebaseTemp()
    }
    
    private var selectedRowIndex: Int?
    
    var numbersOfRowsInSection: Int {
        return self.courseList.count
    }
    
    func selectCourse(_ index: Int) {
        print("index - \(index)")
        print("selectedIndex - \(selectedIndex)")
        if index == selectedIndex {
            selectedIndex = -1
        } else {
            selectedIndex = index
        }
    }
    
    /// 시간표 검증 절차
    /// 1. 이러닝인가 ?
    ///  No
    /// 2. 미래521(수 3,4)인가(a) 미래521(화 3,4 화 5,6)의 형태(b)인가?
    /// A와 B의 메소드를 분리해야 할듯
    /// a1. coredata에 저장된 같은 courseDay의 시간들과 겹치는가?
    /// a2. 겹치면 alert, 겹치지 않으면 시간표 추가 및 dismiss
    /// b1. 문자열 쪼개기
    /// b2. 쪼개진 요일들의 count 계산 (2 or 3)
    /// b3. count만큼 a1의 과정을 거침
    func saveCourse() {
        // 이 이전에 시간표를 검증하는 로직이 필요함.
        //       coreDataManager.saveTimetableCourse(course: course)
        var isDuplicated = false
        guard let courseName = courseList[selectedIndex].courseName,
           let roomName = courseList[selectedIndex].roomName,
           let professor = courseList[selectedIndex].professor,
           let startTime = courseList[selectedIndex].startTime,
           let endTime = courseList[selectedIndex].endTime
        else { return }
        let course = TimetableCourse(courseId: UUID().uuidString, // 케이스 1의 시간표 일 경우
                                     courseName: courseName,
                                     roomName: roomName,
                                     professor: professor,
                                     courseDay: 1,
                                     startTime: startTime,
                                     endTime: endTime)
        
//        let differentCourse = differentPlace(course: course) // 케이스 2의 시간표 일 경우
        let differentTime = differentTime(course: course)
        print(course)
        let timetableCourse = coreDataManager.getTimetableCourseFromCoreData() // courseDay가 동일한 시간표를 호출하는 메소드 필요
        for i in 0..<timetableCourse.count {
            for j in 0..<differentTime.count {
                
                if isCourseDuplicated(existingCourse: timetableCourse[i], newCourse: differentTime[j]) {
                    isDuplicated = true
                    break
                }
            }
        }

        if isDuplicated {
            print("시간표가 중복되었습니다.")
        } else {
            print("시간표를 저장합니다.")
        }
    }
    
    /// ),을 기준으로 쪼개야 함
    // 자연대501(월1),자연대503(수5,6) -> ["자연대501(월1", "자연대503(수5,6)"]
    // 자연대501(월1,2),자연대503(수5,6) -> "자연대501(월1,2", "자연대503(수5,6)"
    // 0 -> courseDay = nextTo(, startTime = nextToCourseDay, endTime = lastString
    // 1 -> courseday = nextTo(, startTIme = nextToCourseDay, endTime = lastString - 1
    func differentPlace(course: TimetableCourse) -> [TimetableCourse] {
        var timeTableCourse: [TimetableCourse] = []
        
        let components = course.roomName.split(separator: "),")
        
        for i in 0..<components.count {
            let firstIndex = components[i].firstIndex(of: "(")
            let dayIndex = components[i].index(after: firstIndex!)
            let startIndex = components[i].index(after: dayIndex)
            
            let dayString = String(components[i][dayIndex])
            let start = String(components[i][startIndex])
            var end = ""
            
            if i == 0 { // lastString
                if let lastString = components[i].last {
                    end = String(lastString)
                }
            } else { // lastString - 1
                let endTimedropLastString = components[i].dropLast()
                if let lastString = endTimedropLastString.last {
                    end = String(lastString)
                }
            }
            let courseDay = dayToInt(courseDay: dayString)
            let startTime = startTimeToString(start: start)
            let endTime = endTimeToString(end: end)
            timeTableCourse.append(TimetableCourse(courseId: UUID().uuidString,
                                                   courseName: course.courseName,
                                                   roomName: course.roomName,
                                                   professor: course.professor,
                                                   courseDay: courseDay,
                                                   startTime: startTime,
                                                   endTime: endTime))
        }
        
        return timeTableCourse
    }
    
    // 자연대112(월1,2 화3,4 수5,6) (월1 수5,6)
    // 공백으로 카운트
    /// 0번째 이후의 로직은 같음
    /// 2개인 경우
    /// "자연대112(월1,2", "화3,4)"
    /// 0 - courseDay = nextTo(, startTime = nextToCourseDay, endTime = lastString
    /// 1 - courseDay = firstString, startTime = nextToCourseDay, endTime = lastString - 1
    /// "자연대112(월1,2", "화3)"
    /// 0 - courseDay = nextTo(, startTime = nextToCourseDay, endTime = lastString
    /// 1 - courseDay = firstString, startTime = nextToCourseDay, endTime = lastString
    /// "자연대112(월1,2", "화3"
    /// 3개인 경우
    ///  "자연대112(월1,2", "화3,4", "수5)"
    /// 0 - courseDay = nextTo(, startTime = nextToCourseDay, endTime = lastString
    /// 1 - courseDay = firstString, startTime = nextToCourseDay, endTime = lastString
    /// 2 - courseDay = firstString, startTime = nextToCourseDay, endTIme = lastString - 1
    func differentTime(course: TimetableCourse) -> [TimetableCourse] {
        var timeTableCourse: [TimetableCourse] = []
        let components = course.roomName.split(separator: " ")
        
        // index == 0
        let firstIndex = components[0].firstIndex(of: "(")
        let firstDayIndex = components[0].index(after: firstIndex!)
        let firstStartIndex = components[0].index(after: firstDayIndex)
        let firstDay = String(components[0][firstDayIndex])
        let firstStartTime = String(components[0][firstStartIndex])
        var firstEndTime = ""
        if let lastString = components[0].last {
            firstEndTime = String(lastString)
        }
        print("day, start, end - \(firstDay), \(firstStartTime), \(firstEndTime)")
        timeTableCourse.append(TimetableCourse(courseId: UUID().uuidString,
                                               courseName: course.courseName,
                                               roomName: course.roomName,
                                               professor: course.professor,
                                               courseDay: dayToInt(courseDay: firstDay),
                                               startTime: startTimeToString(start: firstStartTime),
                                               endTime: endTimeToString(end: firstEndTime)))
        // if count == 3, index == 1
        if components.count == 3 {
            var secondDay = ""
            if let day = components[1].first {
                secondDay = String(day)
            }
            let secondStartIndex = components[1].index(components[1].startIndex, offsetBy: 1)
            let secondStartTime = String(components[1][secondStartIndex])
            var secondEndTime = ""
            if let endTime = components[1].last {
                secondEndTime = String(endTime)
            }
            timeTableCourse.append(TimetableCourse(courseId: UUID().uuidString,
                                                   courseName: course.courseName,
                                                   roomName: course.roomName,
                                                   professor: course.professor,
                                                   courseDay: dayToInt(courseDay: secondDay),
                                                   startTime: startTimeToString(start: secondStartTime),
                                                   endTime: endTimeToString(end: secondEndTime)))
        }
        
        // lastIndex
        var lastDay = ""
        if let day = components[components.count - 1].first {
            lastDay = String(day)
        }
        let lastStartIndex = components[components.count - 1].index(components[components.count - 1].startIndex, offsetBy: 1)
        let lastStartTime = String(components[components.count - 1][lastStartIndex])
        let lastEndIndex = components[components.count - 1].index(before: components[components.count - 1].endIndex)
        let lastEndTime = String(components[components.count - 1][lastEndIndex])
        print("day, start, end - \(lastDay), \(lastStartTime), \(lastEndTime)")
        timeTableCourse.append(TimetableCourse(courseId: UUID().uuidString,
                                               courseName: course.courseName,
                                               roomName: course.roomName,
                                               professor: course.professor,
                                               courseDay: dayToInt(courseDay: lastDay),
                                               startTime: startTimeToString(start: lastStartTime),
                                               endTime: endTimeToString(end: lastEndTime)))
        print(timeTableCourse)
        return timeTableCourse
    }
    
    func getTimetableCourse() {
        
    }
    
    /// func isCourseDuplicated: 강의 중복 확인, String -> Int로 형변환하여 대소비교
    /// 만약 같은 요일에 강의가 존재하고, 11:30 - 13:30에 강의가 존재
    /// 1. startTime
    /// - 11:30 ~ 13:20 사이에 존재한다면 중복
    /// -
    /// 2. endTime
    /// - 11:30 ~ 13:20 사이에 존재한다면 중복
    ///
    /// true : 중복 / false : 노중복
    func isCourseDuplicated(existingCourse: TimetableCourseData, newCourse: TimetableCourse) -> Bool{
        /// 데이터베이스에 저장된 시작 / 종료시간을 Int형으로 변환하여 중복확인을 위한 변수.
        /// - startTime,endTimeStr = "9:30" -> startTime, endTime = 930
        let existingCourseStartTimeStr = existingCourse.startTime?.filter { $0 != ":" }
        let existingCourseEndTimeStr = existingCourse.endTime?.filter { $0 != ":" }
        let newCourseStartTimeStr = newCourse.startTime.filter { $0 != ":" }
        let newCourseEndTimeStr = newCourse.endTime.filter { $0 != ":" }
        guard let existingCourseStartTime = Int(existingCourseStartTimeStr ?? "100"),
              let existingCourseEndTime = Int(existingCourseEndTimeStr ?? "100"),
              let newCourseStartTime = Int(newCourseStartTimeStr),
              let newCourseEndTime = Int(newCourseEndTimeStr)
        else { return true }
        return isTimeDuplicated(existingStart: existingCourseStartTime,
                                existingEnd: existingCourseEndTime,
                                newStart: newCourseStartTime,
                                newEnd: newCourseEndTime)
    }
    
    /// func startTime & endTime To Int
    /// [930, 1030, 1130, 1230, 1330, 1430, 1530, 1630, 1730, 1830, 1930, 2030, 2130, 2230,  2330]
    /// [1020, 1120, 1220, 1320, 1420, 1520, 1620, 1720, 1820, 1920, 2020, 2120, 2220, 2320, 2420]
    func startTimeToInt(start: String) -> Int {
        let startTimeIntArray = [930, 1030, 1130, 1230, 1330, 1430, 1530, 1630, 1730, 1830, 1930, 2030, 2130, 2230, 2330]
        if let index = Int(start) {
            return startTimeIntArray[index]
        }
        // 그럴일이 없지만 숫자가 아닌게 넘어온다면 어떻게 처리해야할까
        return startTimeIntArray[14]
    }
    
    func endTimeToInt(end: String) -> Int {
        let endTimeIntArray = [1020, 1120, 1220, 1320, 1420, 1520, 1620, 1720, 1820, 1920, 2020, 2120, 2220, 2320, 2420]
        if let index = Int(end) {
            return endTimeIntArray[index]
        }
        return endTimeIntArray[14]
    }
    
    /// func timeToString
    /// 930 -> "9:30"
    func startTimeToString(start: String) -> String {
        let startTimeStringArray = ["9:30", "10:30", "11:30", "12:30", "13:30", "14:30", "15:30", "16:30", "17:30", "18:30", "19:30", "20:30", "21:30", "22:30", "23:30"]
        if let index = Int(start) {
            return startTimeStringArray[index]
        }
        return startTimeStringArray[14]
    }
    
    func endTimeToString(end: String) -> String {
        let endTimeStringArray = ["10:20", "11:20", "12:20", "13:20", "14:20", "15:20", "16:20", "17:20", "18:20", "19:20", "20:20", "21:20", "22:20", "23:20", "24:20"]
        if let index = Int(end) {
            return endTimeStringArray[index]
        }
        return endTimeStringArray[14]
    }
    
    /// func dayToInt - 월 -> 1 화 -> 2 수 -> 목
    func dayToInt(courseDay: String) -> Int {
        var dayToString = 6
        switch courseDay {
        case "월":
            dayToString = 1
        case "화":
            dayToString = 2
        case "수":
            dayToString = 3
        case "목":
            dayToString = 4
        case "금":
            dayToString = 5
        default:
            break
        }
        return dayToString
    }
    
    //        if existingStart < newEnd {||
    //            (existingStart == newStart && existingEnd == newEnd) ||
    //            existingEnd > newStart ||
    //            (existingStart >= newStart && existingEnd <= newEnd) ||
    //            (existingStart <= newStart && existingEnd >= newEnd) {
    //            return false
    //        }
    func isTimeDuplicated(existingStart: Int, existingEnd: Int, newStart: Int, newEnd: Int) -> Bool {
//        print("time - \(existingStart) - \(existingEnd), \(newStart) - \(newEnd)")
        if existingStart > newEnd || existingEnd < newStart {
            return false
        }
        return true
    }
    
    func tempStringToDate() {
        let timetableCourseData = coreDataManager.getTimetableCourseFromCoreData()
        
        let courseDataStartTime = timetableCourseData[0].startTime?.filter { $0 != ":" }
        let courseDataEndTime = timetableCourseData[0].endTime?.filter { $0 != ":" }
        guard let startTime = Int(courseDataStartTime ?? "100") else { return }
        guard let endTime = Int(courseDataEndTime ?? "100") else { return }
        print(startTime)
//            .map { Int(String($0)) }
    }
    
    func tempCheckCourse() {
        let temp = coreDataManager.getTimetableCourseFromCoreData()
        print(temp.count)
        for i in 0..<temp.count {
            print("\(i)번째 데이터")
            print(temp[i].courseName)
            print("startTime - \(temp[i].startTime)")
            print("endTime - \(temp[i].endTime)")
        }
    }
    
    func courseViewModelAtIndex(_ index: Int) -> AddCourseViewModel {
        let course = self.courseList[index]
        return AddCourseViewModel(course: course)
    }
    
    func courseSelected(_ index: Int) {
    }
    
    
    func isRowSelected(_ index: Int) -> Bool {
        index != selectedRowIndex
    }
    
}

struct DifferentComponentsCourse {
    let courseDay: Int
    let startTime: String
    let endTime: String
}

//        $selectedIndex
//            .sink { [weak self] index in
//                if index == self?.isSelected {
//                    self?.isSelected = -1
//                }
//                else {
//                    self?.isSelected = index
//                }
//            }
//            .store(in: &bag)
