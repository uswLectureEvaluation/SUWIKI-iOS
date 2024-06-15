//
//  FetchLectureUseCase.swift
//  SUWIKI
//
//  Created by 한지석 on 2/4/24.
//

import Foundation

import DIContainer

public protocol FetchLectureUseCase {
  func excute(
    option: LectureOption,
    page: Int,
    major: String?
  ) async throws -> [Lecture]
}

public final class DefaultFetchLectureUseCase: FetchLectureUseCase {
  @Inject private var repository: LectureRepository
  
  public init() { }
  
  public func excute(
    option: LectureOption,
    page: Int,
    major: String?
  ) async throws -> [Lecture] {
    try await repository.fetch(
      option: option,
      page: page,
      major: major
    )
  }
}
