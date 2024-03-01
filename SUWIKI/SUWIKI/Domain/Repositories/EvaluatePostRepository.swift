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
}
