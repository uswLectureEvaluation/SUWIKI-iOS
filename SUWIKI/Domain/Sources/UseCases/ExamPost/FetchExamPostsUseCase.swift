//
//  FetchExamPostsUseCase.swift
//  SUWIKI
//
//  Created by 한지석 on 3/1/24.
//

import Foundation

import DIContainer

public protocol FetchExamPostsUseCase {
  func execute(
    id: Int,
    page: Int
  ) async throws -> Exam
}

public final class DefaultFetchExamPostUseCase: FetchExamPostsUseCase {
  @Inject private var repository: ExamPostRepository
  
  public init() { }
  
  public func execute(
    id: Int,
    page: Int
  ) async throws -> Exam {
    try await repository.fetch(
      id: id,
      page: page
    )
  }
}
