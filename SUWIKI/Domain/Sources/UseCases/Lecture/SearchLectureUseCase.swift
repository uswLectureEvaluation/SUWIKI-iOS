//
//  SearchLectureUseCase.swift
//  SUWIKI
//
//  Created by 한지석 on 2/4/24.
//

import Foundation

import DIContainer

public protocol SearchLectureUseCase {
  func excute(
    searchText: String,
    option: LectureOption,
    page: Int,
    major: String?
  ) async throws -> [Lecture]
}

public final class DefaultSearchLectureUseCase: SearchLectureUseCase {
  @Inject private var repository: LectureRepository
  
  public init() { }
  
  public func excute(
    searchText: String,
    option: LectureOption, 
    page: Int,
    major: String?
  ) async throws -> [Lecture] {
    try await repository.search(
      searchText: searchText,
      option: option,
      page: page,
      major: major
    )
  }
}
