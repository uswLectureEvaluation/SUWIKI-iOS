//
//  AddCourseListViewModel.swift
//  SUWIKI
//
//  Created by 한지석 on 2023/06/19.
//

import UIKit
import Combine

import DIContainer
import Domain

final class SelectCourseListViewModel {

  @Inject var useCase: FetchFirebaseCourseUseCase

  private let addCourseManager = AddCourseManager()
  var major: String
  var searchText: String
  var searchedCourseList: [FetchCourse] = []
  @Published var courseList: [FetchCourse]

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

  func pushVC(
    fetchCourse: FetchCourse,
    currentVC: UIViewController,
    animated: Bool
  ) {
    let navigationVC = currentVC.navigationController
    let addCourseVC = AddCourseViewController(
      viewModel: AddCourseViewModel(
        fetchCourse: fetchCourse
      )
    )
    navigationVC?.pushViewController(
      addCourseVC,
      animated: animated
    )
  }

}
