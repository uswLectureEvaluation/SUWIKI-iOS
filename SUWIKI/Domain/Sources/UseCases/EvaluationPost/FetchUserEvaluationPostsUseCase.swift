//
//  FetchUserEvaluationPostsUseCase.swift
//  SUWIKI
//
//  Created by 한지석 on 4/4/24.
//

import Foundation

import DIContainer

public protocol FetchUserEvaluationPostsUseCase {
  func execute() async throws -> [UserEvaluationPost]
}

public final class DefaultFetchUserEvaluationPostUseCase: FetchUserEvaluationPostsUseCase {
  @Inject private var repository: EvaluationPostRepository
  
  public init() { }
  
  public func execute() async throws -> [UserEvaluationPost] {
    return try await repository.fetchUserPosts()
  }
}
