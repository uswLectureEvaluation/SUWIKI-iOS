//
//  WriteEvaluatePostUseCase.swift
//  SUWIKI
//
//  Created by 한지석 on 3/29/24.
//

import Foundation

protocol WriteExamPostUseCase {
    func execute(
        id: Int,
        lectureName: String,
        professor: String,
        selectedSemester: String,
        examInfo: String,
        examType: String,
        examDifficulty: String,
        content: String
    ) async throws -> Bool
}

final class DefaultWriteExamPostUseCase: WriteExamPostUseCase {
    @Inject var repository: ExamPostRepository

    func execute(id: Int,
                 lectureName: String,
                 professor: String,
                 selectedSemester: String,
                 examInfo: String,
                 examType: String,
                 examDifficulty: String,
                 content: String
    ) async throws -> Bool {
        return try await repository.write(id: id,
                                          lectureName: lectureName,
                                          professor: professor,
                                          selectedSemester: selectedSemester,
                                          examInfo: examInfo,
                                          examType: examType,
                                          examDifficulty: examDifficulty,
                                          content: content)
    }
}
