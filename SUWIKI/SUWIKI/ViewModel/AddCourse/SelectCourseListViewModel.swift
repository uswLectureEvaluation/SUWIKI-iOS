//
//  AddCourseListViewModel.swift
//  SUWIKI
//
//  Created by 한지석 on 2023/06/19.
//

import UIKit
import Combine

// 0번 ~ 2번 케이스마다 메소드를 분리해서 따로따로 체크를 하는게 좋은 방법인지
// 하나의 메소드에서 분기처리하여 체크할 수 없을까?

class SelectCourseListViewModel: ObservableObject {
    //    var bag = Set<AnyCancellable>()
    let coreDataManager = CoreDataManager.shared
    let addCourseManager = AddCourseManager()
    
    @Published var isSelected: Bool = false
    @Published var isFinished: Bool = false
    
    var searchText = ""
    
    var selectedIndex: Int = -1 {
        didSet {
            isSelected = selectedIndex != -1
        }
    }
    
    var major: String
    var courseList: [FirebaseCourse]
    
    var searchedCourseList: [FirebaseCourse] = []
    
    private var selectedRowIndex: Int?
    
    init(major: String) {
        self.major = major
        self.courseList = CoreDataManager.shared.fetchFirebaseCourse(major: major)
        print(self.courseList[0].courseName)
    }
    // courseList를 계속 접근하기에, getFirebaseCourseFromCoreData() 메소드가 계속 호출됨.
    
    var courseNumbersOfRowsInSection: Int {
        return self.courseList.count
    }
    
    var searchedCourseNumbersOfRowsInSection: Int {
        return self.searchedCourseList.count
    }
    
    
    func selectCourse(_ index: Int) {
        if index == selectedIndex {
            selectedIndex = -1
        } else {
            selectedIndex = index
        }
    }
    
    func courseViewModelAtIndex(_ index: Int) -> SelectCourseViewModel {
        var course = self.courseList[index]
        if !searchText.isEmpty {
            course = self.searchedCourseList[index]
        }
        return SelectCourseViewModel(course: course)
    }
    
    ///func removeSpacingFromSearchText
    func removeSpacingFromSearchText() {
        let removeSpacingSearchText = searchText.replacingOccurrences(of: " ", with: "")
        searchText = removeSpacingSearchText
    }
    
    func pushVC(firebaseCourse: FirebaseCourse, currentVC: UIViewController, animated: Bool) {
        let navigationVC = currentVC.navigationController
        let addCourseVC = AddCourseViewController(viewModel: AddCourseViewModel(firebaseCourse: firebaseCourse))
        navigationVC?.pushViewController(addCourseVC, animated: animated)
    }
    
//    func searchCourseViewModelAtIndex(_ index: Int) -> AddCourseViewModel {
//        let course = self.searchedCourseList[index]
//        return AddCourseViewModel(course: course)
//    }
    
//    func handleNextVC(_ index: Int? = nil, fromCurrentVC: UIViewController, animated: Bool) {
//        // 기존의 멤버가 있을때
//        if let index = index {
//            let memberVM = memberViewModelAtIndex(index)
//            goToNextVC(with: memberVM, fromCurrentVC: fromCurrentVC, animated: animated)
//        // 새로운 멤버 생성시
//        } else {
//            let newVM = MemberViewModel(dataManager: self.dataManager, with: nil, index: nil)
//            goToNextVC(with: newVM, fromCurrentVC: fromCurrentVC, animated: animated)
//        }
//    }
//
//    private func goToNextVC(with memberVM: MemberViewModel, fromCurrentVC: UIViewController, animated: Bool) {
//        let navVC = fromCurrentVC.navigationController
//        let detailVC = DetailViewController(viewModel: memberVM)
//        navVC?.pushViewController(detailVC, animated: animated)
//    }
    
//    func filteredCourseViewModelAtIndex(_ index: Int) -> AddCourseViewModel {
//        let course = self.filteredCourseList[index]
//        return AddCourseViewModel(course: course)
//    }
    
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
//    func saveCourse() -> Bool {
//        var isDuplicated = false
//        guard let courseName = courseList[selectedIndex].courseName,
//              let roomName = courseList[selectedIndex].roomName,
//              let professor = courseList[selectedIndex].professor,
//              let startTime = courseList[selectedIndex].startTime,
//              let endTime = courseList[selectedIndex].endTime,
//              let courseDay = courseList[selectedIndex].courseDay
//        else { return true }
//        let course = TimetableCourse(courseId: UUID().uuidString,
//                                     courseName: courseName,
//                                     roomName: roomName,
//                                     professor: professor,
//                                     courseDay: dayToInt(courseDay: courseDay),
//                                     startTime: startTime,
//                                     endTime: endTime)
//        
//        if roomName.split(separator: " ").count > 1 { // 1. 음악109(화1,2 수3,4)
//            isDuplicated = addCourseManager.saveCourse(newCourse: course, duplicateCase: .differentTime)
//        } else if roomName.split(separator: "),").count > 1 { // 2. 음악109(화1,2),음악110(수1,2)
//            isDuplicated = addCourseManager.saveCourse(newCourse: course, duplicateCase: .differentPlace)
//        } else {
//            isDuplicated = addCourseManager.saveCourse(newCourse: course, duplicateCase: .normal)
//        }
//        
//        return isDuplicated
//    }
    
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
    
    func courseSelected(_ index: Int) {
    }
    
    
    func isRowSelected(_ index: Int) -> Bool {
        index != selectedRowIndex
    }
    
}
