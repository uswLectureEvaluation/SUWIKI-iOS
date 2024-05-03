//
//  ExamPostRepository.swift
//  SUWIKI
//
//  Created by 한지석 on 3/1/24.
//

import Foundation

public protocol ExamPostRepository {
    func fetch(
        id: Int,
        page: Int
    ) async throws -> Exam

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

    func update(
        id: Int,
        selectedSemester: String,
        examInfo: String,
        examType: String,
        examDifficulty: String,
        content: String
    ) async throws -> Bool

    func purchase(id: Int) async throws -> Bool
    func fetchUserPosts() async throws -> [UserExamPost]
    func fetchPurchasedExamPosts() async throws -> [PurchasedPost]
}
