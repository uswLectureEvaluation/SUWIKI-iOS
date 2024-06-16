//
//  DefaultNoticeRepository.swift
//  SUWIKI
//
//  Created by 한지석 on 4/4/24.
//

import Foundation

import Domain
import Network
//let apiProvider: APIProviderProtocol

public final class DefaultNoticeRepository: NoticeRepository {
  
  let apiProvider: APIProviderProtocol
  
  public init(apiProvider: APIProviderProtocol) {
    self.apiProvider = apiProvider
  }
  
  public func fetch() async throws -> [Announcement] {
    let apiTarget = APITarget
      .Notice
      .fetchAnnouncements
    let value = try await apiProvider.request(DTO.FetchAnnouncementResponse.self,
                                              target: apiTarget)
    return value.announcements.map { $0.entity }
  }
  
  public func fetchDetail(id: Int) async throws -> Announcement {
    let apiTarget = APITarget
      .Notice
      .fetchDetailAnnouncement(
        DTO.FetchDetailAnnouncementRequest(noticeId: id)
      )
    let value = try await apiProvider.request(DTO.FetchDetailAnnouncementResponse.self,
                                              target: apiTarget)
    return value.announcement.entity
  }
}
