//
//  ModifyEvaluationPostUseCase.swift
//  SUWIKI
//
//  Created by 한지석 on 4/5/24.
//

import Foundation

import DIContainer

public protocol UpdateEvaluationPostUseCase {
  func execute(
    id: Int,
    lectureName: String,
    professor: String,
    selectedSemester: String,
    satisfaction: Double,
    learning: Double,
    honey: Double,
    team: Int,
    difficulty: Int,
    homework: Int,
    content: String
  ) async throws -> Bool
}

public final class DefaultUpdateEvaluationPostUseCase: UpdateEvaluationPostUseCase {
  @Inject private var repository: EvaluationPostRepository
  
  public init() { }
  
  public func execute(
    id: Int,
    lectureName: String,
    professor: String,
    selectedSemester: String,
    satisfaction: Double,
    learning: Double,
    honey: Double,
    team: Int,
    difficulty: Int,
    homework: Int,
    content: String
  ) async throws -> Bool {
    return try await repository.update(
      id: id,
      lectureName: lectureName,
      professor: professor,
      selectedSemester: selectedSemester,
      satisfaction: satisfaction,
      learning: learning,
      honey: honey,
      team: team,
      difficulty: difficulty,
      homework: homework,
      content: content
    )
  }
}
