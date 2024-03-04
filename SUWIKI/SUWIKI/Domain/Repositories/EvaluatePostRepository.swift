//
//  EvaluatePostRepository.swift
//  SUWIKI
//
//  Created by 한지석 on 2/27/24.
//

import Foundation

protocol EvaluatePostRepository {
    func fetch(
        lectureId: Int,
        page: Int
    ) async throws -> [EvaluatePost]

    func write(
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
