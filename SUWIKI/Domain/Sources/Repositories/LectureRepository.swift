//
//  LectureRepository.swift
//  SUWIKI
//
//  Created by 한지석 on 1/25/24.
//

import Foundation

public protocol LectureRepository {
  func fetch(
    option: LectureOption,
    page: Int,
    major: String?
  ) async throws -> [Lecture]

  func search(
    searchText: String,
    option: LectureOption,
    page: Int,
    major: String?
  ) async throws -> [Lecture]

  func fetchDetail(
    id: Int
  ) async throws -> DetailLecture
}
