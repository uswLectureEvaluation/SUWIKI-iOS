//
//  DTO+FetchExamPostsRequest.swift
//  SUWIKI
//
//  Created by 한지석 on 3/1/24.
//

import Foundation

extension DTO {
    struct FetchExamPostsRequest: Encodable {
        /// 강의 ID
        let lectureId: Int
        /// 페이지(1...)
        let page: Int
    }
}
