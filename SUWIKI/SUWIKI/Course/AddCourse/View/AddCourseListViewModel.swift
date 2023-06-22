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
       coreDataManager.saveTimetableCourse(course: course)
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
    func isCourseDuplicated(course: FirebaseCourseData) {
        
    }
    
    func tempStringToDate() {
        let timetableCourseData = coreDataManager.getTimetableCourseFromCoreData()
        /// 데이터베이스에 저장된 시작 / 종료시간을 Int형으로 변환하여 중복확인을 위한 변수.
        /// - courseDataStartTime,EndTime = "9:30" -> startTime, endTime = 930
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
