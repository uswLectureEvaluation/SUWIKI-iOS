//
//  FetchDetailLectureUseCase.swift
//  SUWIKI
//
//  Created by 한지석 on 2/5/24.
//

import Foundation

import DIContainer

public protocol FetchDetailLectureUseCase {
    func excute(
        id: Int
    ) async throws -> DetailLecture
}

public final class DefaultFetchDetailLectureUseCase: FetchDetailLectureUseCase {
    @Inject private var repository: LectureRepository

    public init() { }

    public func excute(
        id: Int
    ) async throws -> DetailLecture {
        try await repository.fetchDetail(id: id)
    }
}
