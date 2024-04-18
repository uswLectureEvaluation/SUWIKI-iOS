//
//  UpdateExamPostUseCase.swift
//  SUWIKI
//
//  Created by 한지석 on 4/5/24.
//

import Foundation

import DIContainer

protocol UpdateExamPostUseCase {
    func execute(
        id: Int,
        selectedSemester: String,
        examInfo: String,
        examType: String,
        examDifficulty: String,
        content: String
    ) async throws -> Bool
}

final class DefaultUpdateExamPostUseCase: UpdateExamPostUseCase {

    @Inject var repository: ExamPostRepository

    func execute(
        id: Int,
        selectedSemester: String,
        examInfo: String,
        examType: String,
        examDifficulty: String,
        content: String
    ) async throws -> Bool {
        return try await repository.update(id: id,
                                           selectedSemester: selectedSemester,
                                           examInfo: examInfo,
                                           examType: examType,
                                           examDifficulty: examDifficulty,
                                           content: content)
    }
}
