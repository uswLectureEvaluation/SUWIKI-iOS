//
//  FetchLectureUseCase.swift
//  SUWIKI
//
//  Created by 한지석 on 2/4/24.
//

import Foundation

protocol FetchLectureUseCase {
    func excute(
        option: LectureOption,
        page: Int,
        major: String?
    ) async throws -> [Lecture]
}

final class DefaultFetchLectureUseCase: FetchLectureUseCase {

    @Inject var repository: LectureRepository

    func excute(
        option: LectureOption,
        page: Int,
        major: String?
    ) async throws -> [Lecture] {
        try await repository.fetch(option: option,
                                   page: page,
                                   major: major)
    }
}
