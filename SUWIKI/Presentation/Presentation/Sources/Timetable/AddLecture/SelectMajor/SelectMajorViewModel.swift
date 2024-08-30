//
//  DepartmentCategoryViewModel.swift
//  SUWIKI
//
//  Created by 한지석 on 2023/06/01.
//

import Foundation
import UIKit

import DIContainer
import Domain

final class SelectMajorViewModel {

  @Inject var fetchMajorsUseCase: FetchMajorsUseCase
  @Inject var fetchCourseCountUseCase: FetchCourseCountUseCase

  @Published var major: [Major] = []
  var bookmark: [String] = []
  var majorNumberOfRowsInSection: Int {
    return self.major.count
  }

  init() {
    fetchMajors()
  }

  private func fetchMajors() {
    let count = fetchCourseCountUseCase.execute(major: "전체")
    let allMajor = Major(name: "전체", courseCount: count)
    major = [allMajor]
    let majors = fetchMajorsUseCase.execute()
    for i in 0..<majors.count {
      let majorCount = fetchCourseCountUseCase.execute(major: majors[i])
      let currentMajor = Major(name: majors[i], courseCount: majorCount)
      major.append(currentMajor)
    }
    fetchBookmark()
  }

  func toggleBookmark(name: String) {
    let index = self.major.firstIndex(where: { $0.name == name })!
    major[index].bookmark.toggle()
    if let bookmarkIndex = bookmark.firstIndex(where: { $0 == name }) {
      bookmark.remove(at: bookmarkIndex)
    } else {
      bookmark.append(name)
    }
    updateBookmark()
  }

  func updateBookmark() {
    UserDefaults.shared.set(bookmark, forKey: "bookmark")
  }

  func fetchBookmark() {
    if let bookmark = UserDefaults.shared.array(forKey: "bookmark") as? [String] {
      self.bookmark = bookmark
    }
    descendingMajorBookmark()
  }

  func descendingMajorBookmark() {
    bookmark.forEach { bookmark in
      let index = major.firstIndex(where: { $0.name == bookmark })!
      major[index].bookmark = true
    }
    major.sort {
      if $0.bookmark && !$1.bookmark {
        return true
      } else {
        return false
      }
    }
  }

  func pushVC(
    major: String,
    currentVC: UIViewController,
    animated: Bool
  ) {
    let navigationVC = currentVC.navigationController
    let selectCourseVC = SelectCourseViewController(viewModel: SelectCourseListViewModel(major: major))
    navigationVC?.pushViewController(selectCourseVC, animated: animated)
  }
}
