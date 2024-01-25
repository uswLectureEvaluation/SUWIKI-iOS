//
//  LectureRepository.swift
//  SUWIKI
//
//  Created by 한지석 on 1/25/24.
//

import Foundation

protocol LectureRepository {
    func load(
        option: LectureOption,
        page: Int,
        major: String?
    ) async throws -> [Lecture]
}
