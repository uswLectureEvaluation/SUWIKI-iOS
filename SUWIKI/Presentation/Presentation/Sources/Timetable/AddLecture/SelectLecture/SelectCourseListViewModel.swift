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
  var courseList: [FetchCourse] = []
  @Published var searchedCourseList: [FetchCourse] = []
  @Published var searchText = ""

  var major: String
  private var cancellables = Set<AnyCancellable>()

  var courseNumbersOfRowsInSection: Int {
    return self.courseList.count
  }

  var searchedCourseNumbersOfRowsInSection: Int {
    return self.searchedCourseList.count
  }

  init(major: String) {
    self.major = major
    Task {
      self.courseList = useCase.execute(major: major)
      bind()
    }
  }

  private func bind() {
    $searchText
      .map { $0.replacingOccurrences(of: " ", with: "") }
      .removeDuplicates()
      .sink { [weak self] text in
        guard let self else { return }
        if text.isEmpty {
          self.searchedCourseList = []
        } else {
          self.searchedCourseList = self.courseList.filter {
            $0.courseName.lowercased().contains(text.lowercased())
          }
        }
      }
      .store(in: &cancellables)
  }

  func courseViewModelAtIndex(_ index: Int) -> SelectCourseViewModel {
    let course = searchText.isEmpty ? courseList[index] : searchedCourseList[index]
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
