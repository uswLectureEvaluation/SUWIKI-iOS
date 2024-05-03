//
//  DTO+SearchLectureRequest.swift
//  SUWIKI
//
//  Created by 한지석 on 2/2/24.
//

import Foundation

import Domain

extension DTO {
    struct SearchLectureRequest: Encodable {
        /// 교수이름 OR 과목이름
        let searchValue: String
        /// 필터링 옵션
        let option: LectureOption
        /// Fetch Page
        let page: Int
        /// 학과 필터링, 이후 학과 fetch 기능 구현 후 붙힐 예정
        let majorType: String?
    }
}
