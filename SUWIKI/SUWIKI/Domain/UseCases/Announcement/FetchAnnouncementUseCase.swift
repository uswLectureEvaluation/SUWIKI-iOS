//
//  FetchAnnouncementUseCase.swift
//  SUWIKI
//
//  Created by 한지석 on 4/4/24.
//

import Foundation

import DIContainer

protocol FetchAnnouncementUseCase {
    func execute() async throws -> [Announcement]
}

final class DefaultFetchAnnouncementUseCase: FetchAnnouncementUseCase {
    @Inject var repository: NoticeRepository

    func execute() async throws -> [Announcement] {
        return try await repository.fetch()
    }
}
