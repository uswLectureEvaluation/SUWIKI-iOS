//
//  FetchEvaluatePostsUseCase.swift
//  SUWIKI
//
//  Created by 한지석 on 2/27/24.
//

import Foundation

import DIContainer

public protocol FetchEvaluationPostsUseCase {
  func execute(
    lectureId: Int,
    page: Int
  ) async throws -> Evaluation
}

public final class DefaultFetchEvaluationPostsUseCase: FetchEvaluationPostsUseCase {
  @Inject private var repository: EvaluationPostRepository
  
  public init() { }
  
  public func execute(
    lectureId: Int,
    page: Int
  ) async throws -> Evaluation {
    try await repository.fetch(
      lectureId: lectureId, 
      page: page
    )
  }
  
}
