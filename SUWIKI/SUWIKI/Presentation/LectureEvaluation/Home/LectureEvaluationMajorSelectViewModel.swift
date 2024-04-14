//
//  LectureEvaluationMajorSelectViewModel.swift
//  SUWIKI
//
//  Created by 한지석 on 3/31/24.
//

import Foundation
import Combine

final class LectureEvaluationMajorSelectViewModel: ObservableObject {

    var bookmark: [String] = []
    var cancellables = Set<AnyCancellable>()
    @Published var major: [Major] = []
    @Published var searchMajor: [Major] = []
    @Published var searchText: String = ""
    @Published var fetchState: RequestState = .notRequest

    @MainActor
    init() {
        Task {
            let allMajor = Major.majorCount(name: "전체")
            major = [allMajor]
            let majors = try CoreDataManager.shared.fetchMajors()
            for i in 0..<majors.count {
                let majorCount = Major.majorCount(name: majors[i])
                major.append(majorCount)
            }
            fetchBookmark()
        }

        $searchText
            .debounce(for: 0.2, scheduler: DispatchQueue.main)
            .receive(on: RunLoop.main)
            .sink { [weak self] _ in
                self?.search()
            }
            .store(in: &cancellables)
    }

    @MainActor
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

    @MainActor
    func updateBookmark() {
        UserDefaults.shared.set(bookmark, forKey: "bookmark")
    }

    @MainActor
    func fetchBookmark() {
        if let bookmark = UserDefaults.shared.array(forKey: "bookmark") as? [String] {
            self.bookmark = bookmark
        }
        descendingMajorBookmark()
        fetchState = .success
    }

    /// func descendingMajorBookmark: 북마크가 된 학과부터 내림차순으로 정렬합니다.
    @MainActor
    func descendingMajorBookmark() {
        for i in 0..<bookmark.count {
            let index = major.firstIndex { $0.name == bookmark[i] }!
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

    func search() {
        let filteredMajor = major
        self.searchMajor = filteredMajor.filter { $0.name.contains(searchText) }
    }
}
