//
//  FetchAnnouncementUseCase.swift
//  SUWIKI
//
//  Created by 한지석 on 4/4/24.
//

import Foundation

import DIContainer

public protocol FetchAnnouncementUseCase {
  func execute() async throws -> [Announcement]
}

public final class DefaultFetchAnnouncementUseCase: FetchAnnouncementUseCase {
  @Inject private var repository: NoticeRepository
  
  public init() { }
  
  public func execute() async throws -> [Announcement] {
    return try await repository.fetch()
  }
}
