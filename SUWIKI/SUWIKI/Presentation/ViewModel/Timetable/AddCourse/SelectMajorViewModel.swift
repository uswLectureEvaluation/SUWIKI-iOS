//
//  DepartmentCategoryViewModel.swift
//  SUWIKI
//
//  Created by 한지석 on 2023/06/01.
//
import Foundation
import UIKit

final class SelectMajorViewModel {
    
    var major: [Major] = [Major(name: "전체")]
    var bookmark: [String] = []
    var majorNumberOfRowsInSection: Int {
        return self.major.count
    }
    
    init() {
        let majors = CoreDataManager.shared.fetchMajors()
        majors.forEach { major.append(Major(name: $0)) }
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
    
    /// func descendingMajorBookmark: 북마크가 된 학과부터 내림차순으로 정렬합니다.
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
    
    func pushVC(major: String, currentVC: UIViewController, animated: Bool) {
        let navigationVC = currentVC.navigationController
        let selectCourseVC = SelectCourseViewController(viewModel: SelectCourseListViewModel(major: major))
        navigationVC?.pushViewController(selectCourseVC, animated: animated)
    }
    
}
