//
//  FetchLectureUseCase.swift
//  SUWIKI
//
//  Created by 한지석 on 1/27/24.
//

import Foundation

protocol FetchLectureUseCase {
    func fetch(
        option: LectureOption,
        page: Int,
        major: String?
    ) async throws -> [Lecture]
}

struct DefaultFetchLectureUseCase: FetchLectureUseCase {

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
}
