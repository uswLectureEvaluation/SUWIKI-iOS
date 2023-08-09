//
//  AddCourseListViewModel.swift
//  SUWIKI
//
//  Created by 한지석 on 2023/06/19.
//

import Foundation
import Combine

// 0번 ~ 2번 케이스마다 메소드를 분리해서 따로따로 체크를 하는게 좋은 방법인지
// 하나의 메소드에서 분기처리하여 체크할 수 없을까?


class AddCourseListViewModel: ObservableObject {
    //    var bag = Set<AnyCancellable>()
    let coreDataManager = CoreDataManager.shared
    let addCourseManager = AddCourseManager()
    
    @Published var isSelected: Bool = false
    @Published var isFinished: Bool = false
    
    var selectedIndex: Int = -1 {
        didSet {
            isSelected = selectedIndex != -1
        }
    }
    
    private var courseList: [FirebaseCourse] {
        //        print(coreDataManager.getFirebaseTemp())
        //        return coreDataManager.getFirebaseCourseFromCoreData()
        return coreDataManager.getFirebaseCourseFromCoreData()
    }
    
    private var selectedRowIndex: Int?
    
    var numbersOfRowsInSection: Int {
        return self.courseList.count
    }
    
    func selectCourse(_ index: Int) {
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
    func saveCourse() -> Bool {
        var isDuplicated = false
        guard let courseName = courseList[selectedIndex].courseName,
              let roomName = courseList[selectedIndex].roomName,
              let professor = courseList[selectedIndex].professor,
              let startTime = courseList[selectedIndex].startTime,
              let endTime = courseList[selectedIndex].endTime,
              let courseDay = courseList[selectedIndex].courseDay
        else { return true }
        let course = TimetableCourse(courseId: UUID().uuidString,
                                     courseName: courseName,
                                     roomName: roomName,
                                     professor: professor,
                                     courseDay: dayToInt(courseDay: courseDay),
                                     startTime: startTime,
                                     endTime: endTime)
        
        if roomName.split(separator: " ").count > 1 { // 1. 음악109(화1,2 수3,4)
            isDuplicated = addCourseManager.saveCourse(newCourse: course, duplicateCase: .differentTime)
        } else if roomName.split(separator: "),").count > 1 { // 2. 음악109(화1,2),음악110(수1,2)
            isDuplicated = addCourseManager.saveCourse(newCourse: course, duplicateCase: .differentPlace)
        } else {
            isDuplicated = addCourseManager.saveCourse(newCourse: course, duplicateCase: .normal)
        }
        
        return isDuplicated
    }
    
    func dayToInt(courseDay: String) -> Int {
        var dayToString = 0
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
