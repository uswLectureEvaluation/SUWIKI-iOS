//
//  SearchLectureUseCase.swift
//  SUWIKI
//
//  Created by 한지석 on 2/2/24.
//

import Foundation

protocol SearchLectureUseCase {
    func search(
        searchText: String,
        option: LectureOption,
        page: Int,
        major: String?
    ) async throws -> [Lecture]
}

struct DefaultSearchLectureUseCase: SearchLectureUseCase {

    @Inject var repository: LectureRepository

    func search(
        searchText: String,
        option: LectureOption,
        page: Int,
        major: String?
    ) async throws -> [Lecture] {
        try await repository.search(searchText: searchText,
                                    option: option,
                                    page: page,
                                    major: major)
    }
}
