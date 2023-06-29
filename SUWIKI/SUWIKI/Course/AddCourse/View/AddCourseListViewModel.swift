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
        return coreDataManager.getFirebaseCourseFromCoreData()
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
    /// a1. coredata에 저장된 같은 courseDay의 시간들과 겹치는가?
    /// a2. 겹치면 alert, 겹치지 않으면 시간표 추가 및 dismiss
    /// b1. 문자열 쪼개기
    /// b2. 쪼개진 요일들의 count 계산 (2 or 3)
    /// b3. count만큼 a1의 과정을 거침
    func saveCourse() {
        // 이 이전에 시간표를 검증하는 로직이 필요함.
        //       coreDataManager.saveTimetableCourse(course: course)
//        var isDuplicated = false
        guard let courseName = courseList[selectedIndex].courseName,
           let roomName = courseList[selectedIndex].roomName,
           let professor = courseList[selectedIndex].professor,
           let startTime = courseList[selectedIndex].startTime,
           let endTime = courseList[selectedIndex].endTime
        else { return }
        let course = TimetableCourse(courseId: UUID().uuidString,
                                     courseName: courseName,
                                     roomName: roomName,
                                     professor: professor,
                                     courseDay: 1,
                                     startTime: startTime,
                                     endTime: endTime)
        differentPlace(course: course)
        
//        let timetableCourse = coreDataManager.getTimetableCourseFromCoreData()
//        for i in 0..<timetableCourse.count {
//            if isCourseDuplicated(existingCourse: timetableCourse[i], newCourse: course) {
//                isDuplicated = true
//                break
//            }
//        }
//
//        if isDuplicated {
//            print("시간표가 중복되었습니다.")
//        } else {
//            print("시간표를 저장합니다.")
//        }
    }
    
    /// ),을 기준으로 쪼개야 함
    // 자연대501(월1),자연대503(수5,6) -> ["자연대501(월1", "자연대503(수5,6)"]
    // 자연대501(월1,2),자연대503(수5,6) -> "자연대501(월1,2", "자연대503(수5,6)"
    // 0 -> courseDay = nextTo(, startTime = nextToCourseDay, endTime = lastString
    // 1 -> courseday = nextTo(, startTIme = nextToCourseDay, endTime = lastString - 1
    func differentPlace(course: TimetableCourse) -> [TimetableCourse] {
        
        let components = course.roomName.split(separator: "),")
        
        for i in 0..<components.count {
            let firstIndex = components[i].firstIndex(of: "(")
            let dayIndex = components[i].index(after: firstIndex!)
            let startIndex = components[i].index(after: dayIndex)
            
            let courseDay = String(components[i][dayIndex])
            let startTime = String(components[i][startIndex])
            var endTime = ""
            
            if i == 0 { // lastString
                if let lastString = components[i].last {
                    endTime = String(lastString)
                }
            } else { // lastString - 1
                let endTimedropLastString = components[i].dropLast()
                if let lastString = endTimedropLastString.last {
                    endTime = String(lastString)
                }
            }
            
            print(courseDay)
            print(startTime)
            print(endTime)
        }
        
        return [TimetableCourse(courseId: UUID().uuidString,
                                courseName: "courseName",
                                roomName: "roomName",
                                professor: "professor",
                                courseDay: 1,
                                startTime: "startTime",
                                endTime: "endTime")]
    }
    
    // 자연대112(월1,2 화3,4 수5,6) (월1 수5,6)
    // 공백으로 카운트
    /// 0번째 이후의 로직은 같음
    /// 2개인 경우
    /// "자연대112(월1,2", "화3,4"
    /// 0 - courseDay = nextTo(, startTime = nextToCourseDay, endTime = lastString
    /// 1 - courseDay = firstString, startTime = nextToCourseDay, endTime = lastString
    /// "자연대112(월1,2", "화3"
    /// 0 - courseDay = nextTo(, startTime = nextToCourseDay, endTime = lastString
    /// 1 - courseDay = firstString, startTime = nextToCourseDay, endTime = lastString
    /// "자연대112(월1,2", "화3"
    /// 3개인 경우
    ///  "자연대112(월1,2", "화3,4", "수5"
    /// 0 - courseDay = nextTo(, startTime = nextToCourseDay, endTime = lastString
    /// 1 - courseDay = firstString, startTime = nextToCourseDay, endTime = lastString
    /// 2 - courseDay = firstString, startTime = nextToCourseDay, endTIme = lastString
    func differentTime() {
        
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
    func timeToInt() {
        
    }
    
    /// func timeToString
    /// 930 -> "9:30"
    func timeToString() {
        
    }
    
    /// func dayToInt - 월 -> 1 화 -> 2 수 -> 목
    func dayToInt() {
        
    }
    
    func isTimeDuplicated(existingStart: Int, existingEnd: Int, newStart: Int, newEnd: Int) -> Bool {
        print("time - \(existingStart) - \(existingEnd), \(newStart) - \(newEnd)")
//        if existingStart < newEnd {||
//            (existingStart == newStart && existingEnd == newEnd) ||
//            existingEnd > newStart ||
//            (existingStart >= newStart && existingEnd <= newEnd) ||
//            (existingStart <= newStart && existingEnd >= newEnd) {
//            return false
//        }
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
