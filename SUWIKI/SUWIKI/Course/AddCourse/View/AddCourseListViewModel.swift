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
        let course = TimetableCourse(courseId: UUID().uuidString,
                                     courseName: courseName,
                                     roomName: roomName,
                                     professor: professor,
                                     courseDay: 1,
                                     startTime: startTime,
                                     endTime: endTime)
        let timetableCourse = coreDataManager.getTimetableCourseFromCoreData()
        for i in 0..<timetableCourse.count {
            if isCourseDuplicated(existingCourse: timetableCourse[i], newCourse: course) {
                isDuplicated = true
                break
            }
        }
        
        if isDuplicated {
            print("시간표가 중복되었습니다.")
        } else {
            print("시간표를 저장합니다.")
        }
        
    }
    
    func getTimetableCourse() {
        
    }
    
    /// 같은 요일에 강의가 존재한다면,
    /// 만약 11:30 - 13:30에 강의가 존재
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
