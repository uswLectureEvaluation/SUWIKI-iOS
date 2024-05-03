//
//  WriteEvaluatePostUseCase.swift
//  SUWIKI
//
//  Created by 한지석 on 3/3/24.
//

import Foundation

import DIContainer

public protocol WriteEvaluationPostUseCase {
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

public final class DefaultWriteEvaluationPostUseCase: WriteEvaluationPostUseCase {
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
        try await repository.write(
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
