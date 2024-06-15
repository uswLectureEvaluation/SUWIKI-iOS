//
//  FetchDetailAnnouncementUseCase.swift
//  SUWIKI
//
//  Created by 한지석 on 4/4/24.
//

import Foundation

import DIContainer

public protocol FetchDetailAnnouncementUseCase {
  func execute(
    id: Int
  ) async throws -> Announcement
}

public final class DefaultFetchDetailAnnouncementUseCase: FetchDetailAnnouncementUseCase {
  @Inject private var repository: NoticeRepository
  
  public init() { }
  
  public func execute(
    id: Int
  ) async throws -> Announcement {
    return try await repository.fetchDetail(id: id)
  }
}
