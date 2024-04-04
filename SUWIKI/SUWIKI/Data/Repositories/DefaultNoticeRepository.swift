//
//  DefaultNoticeRepository.swift
//  SUWIKI
//
//  Created by 한지석 on 4/4/24.
//

import Foundation

final class DefaultNoticeRepository: NoticeRepository {
    func fetch() async throws -> [Announcement] {
        let apiTarget = APITarget
            .Notice
            .fetchAnnouncements
        let value = try await APIProvider.request(DTO.FetchAnnouncementResponse.self,
                                                  target: apiTarget)
        return value.announcements.map { $0.entity }
    }

    func fetchDetail(id: Int) async throws -> Announcement {
        let apiTarget = APITarget
            .Notice
            .fetchDetailAnnouncement(
                DTO.FetchDetailAnnouncementRequest(noticeId: id)
            )
        let value = try await APIProvider.request(DTO.FetchDetailAnnouncementResponse.self,
                                                  target: apiTarget)
        return value.announcement.entity
    }
}
