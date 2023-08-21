//
//  DepartmentCategoryViewModel.swift
//  SUWIKI
//
//  Created by 한지석 on 2023/06/01.
//
import Foundation
import UIKit

final class SelectMajorViewModel {
    
    var major: [Major] = MajorNames.list.map { Major(name: $0) }
    var bookmark: [String] = []
    var majorNumberOfRowsInSection: Int {
        return self.major.count
    }
    
    init() {
        fetchBookmark()
    }
    
//    struct Input {
//        let selectMajor = PublishSubject<String>()
//    }
//
//    struct Output {
//        let selectedMajor = PublishSubject<String>()
//    }
//
//    let input = Input()
//    let output = Output()
//    var cancellable = Set<AnyCancellable>()
    
    func toggleBookmark(name: String) {
        let index = self.major.firstIndex(where: { $0.name == name })!
        major[index].bookmark.toggle()
        if let bookmarkIndex = bookmark.firstIndex(where: { $0 == name }) {
            //MARK: 삭제
            bookmark.remove(at: bookmarkIndex)
        } else {
            //MARK: 추가
            bookmark.append(name)
        }
        updateBookmark()
    }
    
    func updateBookmark() {
        UserDefaults.standard.set(bookmark, forKey: "bookmark")
    }
    
    func fetchBookmark() {
        if let bookmark = UserDefaults.standard.array(forKey: "bookmark") as? [String] {
            self.bookmark = bookmark
            print("@Log \(self.bookmark)")
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
    
    func selectedMajor(major: String) {
        print(major)
    }
    
    func pushVC(major: String, currentVC: UIViewController, animated: Bool) {
        let navigationVC = currentVC.navigationController
        let selectCourseVC = SelectCourseViewController(viewModel: SelectCourseListViewModel(major: major))
        navigationVC?.pushViewController(selectCourseVC, animated: animated)
    }
    
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
    
}
