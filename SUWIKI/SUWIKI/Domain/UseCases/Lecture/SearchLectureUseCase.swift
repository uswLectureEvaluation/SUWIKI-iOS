//
//  SearchLectureUseCase.swift
//  SUWIKI
//
//  Created by 한지석 on 2/4/24.
//

import Foundation

import DIContainer

protocol SearchLectureUseCase {
    func excute(
        searchText: String,
        option: LectureOption,
        page: Int,
        major: String?
    ) async throws -> [Lecture]
}

final class DefaultSearchLectureUseCase: SearchLectureUseCase {

    @Inject var repository: LectureRepository

    func excute(
        searchText: String,
        option: LectureOption, 
        page: Int,
        major: String?
    ) async throws -> [Lecture] {
        try await repository.search(searchText: searchText, option: option, page: page, major: major)
    }
}
