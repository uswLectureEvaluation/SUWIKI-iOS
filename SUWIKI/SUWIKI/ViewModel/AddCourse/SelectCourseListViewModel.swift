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
    
    let coreDataManager = CoreDataManager.shared
    let addCourseManager = AddCourseManager()
//    @Published var isSelected: Bool = false
//    @Published var isFinished: Bool = false
    
    var searchText = ""
    
    // courseList를 계속 접근하기에, getFirebaseCourseFromCoreData() 메소드가 계속 호출됨.
    var searchedCourseList: [FirebaseCourse] = []
    
    var major: String
    var courseList: [FirebaseCourse]
    
    init(major: String) {
        self.major = major
        self.courseList = CoreDataManager.shared.fetchFirebaseCourse(major: major)
    }
    
    var courseNumbersOfRowsInSection: Int {
        return self.courseList.count
    }
    
    var searchedCourseNumbersOfRowsInSection: Int {
        return self.searchedCourseList.count
    }
    
    func courseViewModelAtIndex(_ index: Int) -> SelectCourseViewModel {
        var course = self.courseList[index]
        if !searchText.isEmpty {
            course = self.searchedCourseList[index]
        }
        return SelectCourseViewModel(course: course)
    }
    
    func removeSpacingFromSearchText() {
        let removeSpacingSearchText = searchText.replacingOccurrences(of: " ", with: "")
        searchText = removeSpacingSearchText
    }
    
    func pushVC(firebaseCourse: FirebaseCourse, currentVC: UIViewController, animated: Bool) {
        let navigationVC = currentVC.navigationController
        let addCourseVC = AddCourseViewController(viewModel: AddCourseViewModel(firebaseCourse: firebaseCourse))
        navigationVC?.pushViewController(addCourseVC, animated: animated)
    }
    
}
