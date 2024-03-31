//
//  ExamPostRepository.swift
//  SUWIKI
//
//  Created by 한지석 on 3/1/24.
//

import Foundation

protocol ExamPostRepository {
    func fetch(
        id: Int,
        page: Int
    ) async throws -> ExamPostInfo

    func write(
        id: Int,
        lectureName: String,
        professor: String,
        selectedSemester: String,
        examInfo: String,
        examType: String,
        examDifficulty: String,
        content: String
    ) async throws -> Bool

    func purchase(id: Int) async throws -> Bool
}
