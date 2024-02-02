//
//  LectureEvaluationHomeViewModel.swift
//  SUWIKI
//
//  Created by 한지석 on 1/27/24.
//

import Foundation

final class LectureEvaluationHomeViewModel: ObservableObject {
    
    var useCase: FetchLectureUseCase = DIContainer.shared.resolve(type: FetchLectureUseCase.self)
    var searchUseCase: SearchLectureUseCase = DIContainer.shared.resolve(type: SearchLectureUseCase.self)
    var fetchLecture: [Lecture] = []
    var searchLecture: [Lecture] = []
    @Published var lecture: [Lecture] = []
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
    @Published var major: String? = nil
    @Published var searchText: String = "" {
        didSet {
            searchPage = 1
            if searchText.isEmpty {
                lecture = fetchLecture
            }
        }
    }
    @Published var isMajorSelectSheetPresented: Bool = false

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
    
    @MainActor
    func fetch() async throws {
        do {
            if self.fetchPage == 1 {
                fetchLecture = try await useCase.fetch(option: option,
                                                       page: fetchPage,
                                                       major: major)
                self.lecture = fetchLecture
            } else {
                let fetchData = try await useCase.fetch(option: option,
                                                        page: fetchPage,
                                                        major: major)
                fetchLecture.append(contentsOf: fetchData)
                self.lecture.append(contentsOf: fetchData)
            }
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    @MainActor
    func search() async throws {
        guard !searchText.isEmpty else { return }
        
        do {
            if self.searchPage == 1 {
                searchLecture = try await searchUseCase.search(searchText: searchText,
                                                               option: option,
                                                               page: searchPage,
                                                               major: major)
                lecture = searchLecture
            } else {
                let searchData = try await searchUseCase.search(searchText: searchText,
                                                                option: option,
                                                                page: searchPage,
                                                                major: major)
                searchLecture.append(contentsOf: searchData)
                lecture.append(contentsOf: searchData)
            }
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}
