//
//  LectureUseCase.swift
//  SUWIKI
//
//  Created by 한지석 on 2/3/24.
//

import Foundation

protocol LectureUseCase {
    func fetch(
        option: LectureOption,
        page: Int,
        major: String?
    ) async throws -> [Lecture]
    func search(
        searchText: String,
        option: LectureOption,
        page: Int,
        major: String?
    ) async throws -> [Lecture]
}

final class DefaultLectureUseCase: LectureUseCase {

    @Inject var repository: LectureRepository

    func fetch(
        option: LectureOption,
        page: Int,
        major: String?
    ) async throws -> [Lecture] {
        try await repository.fetch(option: option,
                                   page: page,
                                   major: major)
    }

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
