//
//  DTO+AllLectureRequest.swift
//  SUWIKI
//
//  Created by 한지석 on 1/25/24.
//

import Foundation

import Domain

extension DTO {
  public struct AllLectureRequest: Encodable {
    /// 필터링 옵션
    public let option: LectureOption
    /// Fetch Page
    public let page: Int
    /// 학과 필터링, 이후 학과 fetch 기능 구현 후 붙힐 예정
    public let majorType: String?

    public init(
      option: LectureOption,
      page: Int,
      majorType: String?
    ) {
      self.option = option
      self.page = page
      self.majorType = majorType
    }
  }
}
