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

final class SelectCourseListViewModel {

    @Inject var useCase: FetchFirebaseCourseUseCase

    private let addCourseManager = AddCourseManager()
    var major: String
    var searchText: String
    var searchedCourseList: [FirebaseCourse] = []
    @Published var courseList: [FirebaseCourse]

    init(major: String) {
        self.major = major
        self.searchText = ""
        self.courseList = []
        Task {
            print("@INIT")
            self.courseList = useCase.execute(major: major)
        }
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
