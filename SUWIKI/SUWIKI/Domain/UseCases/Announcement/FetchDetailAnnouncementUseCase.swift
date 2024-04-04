//
//  FetchDetailAnnouncementUseCase.swift
//  SUWIKI
//
//  Created by 한지석 on 4/4/24.
//

import Foundation

protocol FetchDetailAnnouncementUseCase {
    func execute(id: Int) async throws -> Announcement
}

final class DefaultFetchDetailAnnouncementUseCase: FetchDetailAnnouncementUseCase {
    @Inject var repository: NoticeRepository

    func execute(id: Int) async throws -> Announcement {
        return try await repository.fetchDetail(id: id)
    }
}
