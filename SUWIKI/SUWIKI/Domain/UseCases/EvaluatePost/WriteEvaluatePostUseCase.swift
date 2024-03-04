//
//  WriteEvaluatePostUseCase.swift
//  SUWIKI
//
//  Created by 한지석 on 3/3/24.
//

import Foundation

protocol WriteEvaluatePostUseCase {
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

final class DefaultWriteEvaluatePostUseCase: WriteEvaluatePostUseCase {

    @Inject var repository: EvaluatePostRepository

    func execute(id: Int,
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
        try await repository.write(id: id,
                                   lectureName: lectureName,
                                   professor: professor,
                                   selectedSemester: selectedSemester,
                                   satisfaction: satisfaction,
                                   learning: learning,
                                   honey: honey,
                                   team: team,
                                   difficulty: difficulty,
                                   homework: homework,
                                   content: content)
    }
}
