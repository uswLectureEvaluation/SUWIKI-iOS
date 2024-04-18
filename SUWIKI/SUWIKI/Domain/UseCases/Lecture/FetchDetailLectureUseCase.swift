//
//  FetchDetailLectureUseCase.swift
//  SUWIKI
//
//  Created by 한지석 on 2/5/24.
//

import Foundation

import DIContainer

protocol FetchDetailLectureUseCase {
    func excute(
        id: Int
    ) async throws -> DetailLecture
}

final class DefaultFetchDetailLectureUseCase: FetchDetailLectureUseCase {

    @Inject var repository: LectureRepository

    func excute(
        id: Int
    ) async throws -> DetailLecture {
        try await repository.fetchDetail(id: id)
    }
}
