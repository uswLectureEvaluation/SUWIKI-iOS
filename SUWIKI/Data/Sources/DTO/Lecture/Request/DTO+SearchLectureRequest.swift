//
//  DTO+SearchLectureRequest.swift
//  SUWIKI
//
//  Created by 한지석 on 2/2/24.
//

import Foundation

import Domain

extension DTO {
    public struct SearchLectureRequest: Encodable {
        /// 교수이름 OR 과목이름
        public let searchValue: String
        /// 필터링 옵션
        public let option: LectureOption
        /// Fetch Page
        public let page: Int
        /// 학과 필터링, 이후 학과 fetch 기능 구현 후 붙힐 예정
        public let majorType: String?

        public init(
            searchValue: String,
            option: LectureOption,
            page: Int,
            majorType: String?
        ) {
            self.searchValue = searchValue
            self.option = option
            self.page = page
            self.majorType = majorType
        }
    }
}
