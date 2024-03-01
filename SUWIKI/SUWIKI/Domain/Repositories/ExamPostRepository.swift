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
}
