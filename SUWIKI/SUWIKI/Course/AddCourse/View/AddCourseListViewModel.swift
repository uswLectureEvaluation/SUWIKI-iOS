//
//  AddCourseListViewModel.swift
//  SUWIKI
//
//  Created by 한지석 on 2023/06/19.
//

import Foundation
import Combine

class AddCourseListViewModel: ObservableObject {
    var bag = Set<AnyCancellable>()
    let coreDataManager = CoreDataManager.shared
    var isSelected: Int = -1
    @Published var selectedIndex = -1
//    var temp = CurrentValueSubject<Int, Never>(-1)
    // combine을 연결해서 할 거라면
    // 고민해보자
    // subject에서 데이터를 관리하고 바뀌는 걸
    
    
    init() {
        
        $selectedIndex
            .sink { [weak self] index in
                if index == self?.isSelected {
                    self?.isSelected = -1
                }
                else {
                    self?.isSelected = index
                }
            }
            .store(in: &bag)
    }
    
    private var courseList: [FirebaseCourseData] {
        return coreDataManager.getFirebaseCourseFromCoreData()
    }
    
    private var selectedRowIndex: Int?
    
    var numbersOfRowsInSection: Int {
        return self.courseList.count
    }
    
    func saveSelectedCourse() {
        guard let courseName = courseList[isSelected].courseName,
           let roomName = courseList[isSelected].roomName,
           let professor = courseList[isSelected].professor,
           let startTime = courseList[isSelected].startTime,
           let endTime = courseList[isSelected].endTime
        else { return }
        let course = TimetableCourse(courseId: UUID().uuidString,
                                     courseName: courseName,
                                     roomName: roomName,
                                     professor: professor,
                                     courseDay: 1,
                                     startTime: startTime,
                                     endTime: endTime)
       coreDataManager.saveTimetableCourse(course: course)
        print(self.courseList[isSelected])
    }
    
    func tempCheckCourse() {
        let temp = coreDataManager.getTimetableCourseFromCoreData()
        print(temp[0].courseName)
    }
    
    func isRowSelected(_ index: Int) -> Bool {
        index != selectedRowIndex
    }
    
    func courseViewModelAtIndex(_ index: Int) -> AddCourseViewModel {
        let course = self.courseList[index]
        return AddCourseViewModel(course: course)
    }
    
    func courseSelected(_ index: Int) {
    }
}
