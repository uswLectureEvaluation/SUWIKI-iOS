//
//  LectureEvaluationHomeViewModel.swift
//  SUWIKI
//
//  Created by 한지석 on 1/27/24.
//

import Foundation

final class LectureEvaluationHomeViewModel: ObservableObject {

    @Inject var fetchUseCase: FetchLectureUseCase
    @Inject var searchUseCase: SearchLectureUseCase
    var fetchLecture: [Lecture] = []
    var searchLecture: [Lecture] = []
    @Published var lecture: [Lecture] = []
    
    /// UserDefaults
    @Published var option: LectureOption = .modifiedDate {
        didSet {
            fetchPage = 1
            searchPage = 1
            Task {
                try await fetch()
                try await search()
            }
        }
    }
    @Published var fetchPage: Int = 1
    @Published var searchPage: Int = 1
    /// UserDefaults
    @Published var major: String = "전체" {
        didSet {
            searchPage = 1
            fetchPage = 1
            Task {
                try await fetch()
                try await search()
            }
        }
    }
    @Published var searchText: String = "" {
        didSet {
            searchPage = 1
            if searchText.isEmpty {
                lecture = fetchLecture
            }
        }
    }
    @Published var isMajorSelectSheetPresented = false
    @Published var isLoginViewPresented = false
    @Published var isLoggedOut = false

    init() {
        Task {
            try await fetch()
        }
    }
    
    @MainActor
    func update() async throws {
        /// Pagination
        searchText.isEmpty ? (fetchPage += 1) : (searchPage += 1)
        /// update할 메소드 고르기
        searchText.isEmpty ? try await fetch() : try await search()
    }
    
    /// func fetch: 강의평가를 서버에서 내려받습니다.
    /// 무한스크롤 기능을 위해 페이지가 1일 경우 fetch 데이터로 초기화, 아닐 경우 append 합니다.
    @MainActor
    func fetch() async throws {
        do {
            if self.fetchPage == 1 {
                fetchLecture = try await fetchUseCase.excute(option: option,
                                                       page: fetchPage,
                                                       major: major)
                self.lecture = fetchLecture
            } else {
                let fetchData = try await fetchUseCase.excute(option: option,
                                                        page: fetchPage,
                                                        major: major)
                fetchLecture.append(contentsOf: fetchData)
                self.lecture.append(contentsOf: fetchData)
            }
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    /// func search: 강의평가를 검색한 후, 검색 데이터를 서버에서 내려받습니다.
    /// 무한스크롤 기능을 위해 페이지가 1일 경우 search 데이터로 초기화, 아닐 경우 append 합니다.
    func search() async throws {
        guard !searchText.isEmpty else { return }
        do {
            if self.searchPage == 1 {
                searchLecture = try await searchUseCase.excute(searchText: searchText,
                                                               option: option,
                                                               page: searchPage,
                                                               major: major)
                await MainActor.run {
                    lecture = searchLecture
                }
            } else {
                let searchData = try await searchUseCase.excute(searchText: searchText,
                                                                option: option,
                                                                page: searchPage,
                                                                major: major)
                await MainActor.run {
                    searchLecture.append(contentsOf: searchData)
                    lecture.append(contentsOf: searchData)
                }
            }
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}
